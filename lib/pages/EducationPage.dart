// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EducationItem(
              year: 'En Cours',
              institution:
                  'Mastère Professionnel En Développement Des Systèmes Informatiques Et Réseaux (DSIR)',
              degree: '',
            ),
            SizedBox(height: 20),
            EducationItem(
              year: '2022',
              institution:
                  'Licence En Informatique De La Gestion (Business Intelligence)',
              degree: '',
            ),
            SizedBox(height: 20),
            EducationItem(
              year: '2019',
              institution: 'Baccalauréat En Informatique',
              degree: '',
            ),
            SizedBox(height: 20),
            // Ajoutez d'autres widgets EducationItem pour d'autres détails d'éducation
          ],
        ),
      ),
    );
  }
}

class EducationItem extends StatelessWidget {
  final String year;
  final String institution;
  final String degree;

  const EducationItem({
    required this.year,
    required this.institution,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: 4,
            height: 50,
            color: Colors.grey[300],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                year,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                institution,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                degree,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
