import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddEducationPage extends StatefulWidget {
  final VoidCallback onEducationAdded;

  const AddEducationPage({Key? key, required this.onEducationAdded})
      : super(key: key);

  @override
  _AddEducationPageState createState() => _AddEducationPageState();
}

class _AddEducationPageState extends State<AddEducationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _year;
  late String _institution;
  late String _degree;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(
          'id'); // Récupérer l'ID de l'utilisateur depuis le localStorage
      final educationData = {
        'year': _year,
        'institution': _institution,
        'userId': userId, // Ajouter l'ID de l'utilisateur dans la requête
      };

      // Envoi des données à l'API
      addEducationData(educationData);
    }
  }

  Future<void> addEducationData(Map<String, dynamic> educationData) async {
    final url = 'http://localhost:3000/education'; // URL de l'API json-server

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(educationData),
    );

    if (response.statusCode == 201) {
      // Succès : données ajoutées avec succès
      print('Education data added successfully');
      widget.onEducationAdded(); // Appel de la fonction de rappel
      Navigator.pop(context); // Revenir à la page précédente
    } else {
      // Erreur : échec de l'ajout des données
      print('Failed to add education data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Education')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a year';
                  }
                  return null;
                },
                onSaved: (value) {
                  _year = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Institution'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an institution';
                  }
                  return null;
                },
                onSaved: (value) {
                  _institution = value!;
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
