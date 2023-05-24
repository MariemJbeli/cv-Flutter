import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/AddEducationPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  List<Map<String, dynamic>> educationData = [];
  int? userId; // Ajout de la variable pour stocker l'ID de l'utilisateur

  Future<void> fetchEducationData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs
        .getInt('id'); // Récupérer l'ID de l'utilisateur depuis le localStorage

    final url =
        'http://localhost:3000/Education?userId=$userId'; // URL de l'API json-server

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        educationData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      print('Failed to fetch education data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEducationData();
  }

  void _onEducationAdded() {
    fetchEducationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Builder(
          builder: (context) {
            if (educationData.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: educationData.length,
                      itemBuilder: (context, index) {
                        final item = educationData[index];
                        return EducationCard(
                          year: item['year'],
                          institution: item['institution'],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEducationPage(
                onEducationAdded: _onEducationAdded,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EducationCard extends StatelessWidget {
  final String year;
  final String institution;

  const EducationCard({
    required this.year,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0072FF),
              Color(0xFF00C6FF),
            ],
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              year,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              institution,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
