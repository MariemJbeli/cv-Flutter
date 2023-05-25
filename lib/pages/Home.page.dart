// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/CompetancePage.dart';
import 'package:flutterauth3/pages/EducationPage.dart';
import 'package:flutterauth3/pages/SkillsPage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'AboutMePage.dart';
import 'package:flutterauth3/pages/Project.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Index de l'onglet sélectionné
  late SharedPreferences prefs;
  static const List<Widget> _widgetOptions = <Widget>[
    AboutMePage1(),
    ProjectsPage1(),
    EducationPage1(),
    CompetancePage1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Déconnexion"),
                    content: const Text("Voulez-vous vous déconnecter ?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("ANNULER"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("DÉCONNEXION"),
                        onPressed: () {
                          Deconnexion(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About Me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code), // Remplacez ici par l'icône correspondante
            label: 'Competence',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink, // Couleur de l'onglet sélectionné
        unselectedItemColor:
            Colors.grey, // Couleur des onglets non sélectionnés
      ),
    );
  }

  Future<void> Deconnexion(context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);

    Navigator.of(context).pushNamedAndRemoveUntil(
        '/authentification', (Route<dynamic> route) => false);
  }
}

class AboutMePage1 extends StatelessWidget {
  const AboutMePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutMePage(),
    );
  }
}

class ProjectsPage1 extends StatelessWidget {
  const ProjectsPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProjectsPage(),
    );
  }
}

class EducationPage1 extends StatelessWidget {
  const EducationPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EducationPage(),
    );
  }
}

class CompetancePage1 extends StatelessWidget {
  const CompetancePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompetancePage(),
    );
  }
}
