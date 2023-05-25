import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/AddSkillsPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
            MaterialPageRoute(
              builder: (context) => AddSkillsPage(
                onSkillsAdded: () {
                  _fetchSkills(); // Mettre à jour les projets après l'ajout d'un nouveau projet
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: skills.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compétences',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: skills.length,
                    itemBuilder: (BuildContext context, int index) {
                      final skill = skills[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              skill.imageUrl,
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(height: 10),
                            Text(
                              skill.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
