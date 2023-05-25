import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/AddSkillsPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AddProject.dart';
import 'dart:convert';

class Skill {
  final String title;
  final String imageUrl;

  Skill({required this.title, required this.imageUrl});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }
}

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<Skill> skills = [];

  Future<void> _fetchSkills() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs
        .getInt('id'); // Récupérer l'ID de l'utilisateur depuis le localStorage
    final response = await http
        .get(Uri.parse('http://localhost:3000/skills?userId=$userId'));
    final List<dynamic> skillsJson = jsonDecode(response.body);
    setState(() {
      skills = skillsJson.map((json) => Skill.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSkillsPage()),
          ).then((value) {
            if (value == true) {
              _fetchSkills();
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: skills.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: skills.length,
              itemBuilder: (BuildContext context, int index) {
                final skill = skills[index];
                return ListTile(
                  leading: Image.network(skill.imageUrl),
                  title: Text(skill.title),
                );
              },
            ),
    );
  }
}
