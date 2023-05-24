import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AddProject.dart';
import 'dart:convert';

class Project {
  final String title;
  final String description;
  final String imageUrl;

  Project(
      {required this.title, required this.description, required this.imageUrl});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> _projects = [];

  Future<void> _fetchProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs
        .getInt('id'); // Récupérer l'ID de l'utilisateur depuis le localStorage
    final response = await http
        .get(Uri.parse('http://localhost:3000/projects?userId=$userId'));
    final List<dynamic> projectsJson = jsonDecode(response.body);
    setState(() {
      _projects = projectsJson.map((json) => Project.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: _projects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _projects.length,
              itemBuilder: (BuildContext context, int index) {
                final project = _projects[index];
                return ListTile(
                  leading: Image.network(project.imageUrl),
                  title: Text(project.title),
                  subtitle: Text(project.description),
                );
              },
            ),
    );
  }
}
