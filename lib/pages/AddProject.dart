// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/Project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
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

      final response = await http.post(
        Uri.parse('http://localhost:3000/projects'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _title,
          'description': _description,
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProjectsPage()),
        );
      } else {
        throw Exception('Failed to add project');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
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
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
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
