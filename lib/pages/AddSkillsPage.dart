import 'package:flutter/material.dart';

import 'package:flutterauth3/pages/SkillsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSkillsPage extends StatefulWidget {
  // const AddSkillsPage({Key? key}) : super(key: key);
  final VoidCallback onSkillsAdded;

  const AddSkillsPage({Key? key, required this.onSkillsAdded})
      : super(key: key);
  @override
  _AddSkillsPageState createState() => _AddSkillsPageState();
}

class _AddSkillsPageState extends State<AddSkillsPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;

  String? _imageUrl;

  final cloudinary = CloudinaryPublic('dcd85e7v0', 'lcxie1ud', cache: false);
  Future<void> _uploadImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(pickedImage.path,
            resourceType: CloudinaryResourceType.Image),
      );
      print(response.secureUrl);
      setState(() {
        _imageUrl = response.secureUrl;
      });
    }
  }

  void _submitForm() async {
    String imageUrl = _imageUrl ?? '';
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(
          'id'); // Récupérer l'ID de l'utilisateur depuis le localStorage

      final response = await http.post(
        Uri.parse('http://localhost:3000/skills'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _title,

          'imageUrl': imageUrl,
          'userId': userId, // Ajouter l'ID de l'utilisateur dans la requête
        }),
      );

      if (response.statusCode == 201) {
        widget.onSkillsAdded();
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add project');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add skill')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _uploadImage,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload),
                        const SizedBox(width: 10.0),
                        Text('Upload Image'),
                      ],
                    ),
                  ),
                ),
                if (_imageUrl != null) Image.network(_imageUrl!),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
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
      ),
    );
  }
}
