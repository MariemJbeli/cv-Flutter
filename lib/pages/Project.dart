// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AddProject.dart';
import 'dart:convert';

// class ProjectService {
//   static const String baseUrl = 'http://localhost:3000';

//   static Future<List<Project>> getProjects() async {
//     final response = await http.get(Uri.parse('$baseUrl/projects'));
//     if (response.statusCode == 200) {
//       List<dynamic> projectsJson = jsonDecode(response.body);
//       return projectsJson.map((json) => Project.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load projects');
//     }
//   }
// }

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
    final response =
        await http.get(Uri.parse('http://localhost:3000/projects'));
    final List<dynamic> projectsJson = json.decode(response.body);
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
