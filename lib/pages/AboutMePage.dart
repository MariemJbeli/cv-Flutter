import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String password;
  String imageUrl;

  User({
    required this.username,
    required this.password,
    required this.imageUrl,
  });
}

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  User? user; // Store the current user
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool connecte = prefs.getBool('connecte') ?? false;
    String? username = prefs.getString('username');

    if (connecte && username != null) {
      final response = await http
          .get(Uri.parse('http://localhost:3000/users?username=$username'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        if (jsonData.isNotEmpty) {
          final userData = jsonData[0];
          user = User(
            username: userData['username'],
            password: userData['password'],
            imageUrl: userData['imageUrl'],
          );
        }
      } else {
        // Handle error
      }
    } else {
      // User is not logged in
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        user != null ? NetworkImage(user!.imageUrl) : null,
                  ),
                  SizedBox(height: 20),
                  Text(
                    user != null ? user!.username : '',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mobile App Developer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "En tant que perfectionniste et créatif, j'ai plaisir à apporter une valeur ajoutée et à contribuer à l'amélioration de ce qui existe déjà. Je suis également dynamique et je préfère travailler en équipe pour relever des défis techniques. Avec une solide maîtrise des outils de développement, je suis constamment en quête de nouvelles connaissances et compétences.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
