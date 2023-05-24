import 'package:flutter/material.dart';

class EducationItem extends StatelessWidget {
  final String year;
  final String institution;

  const EducationItem({
    required this.year,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Year: $year'),
        Text('Institution: $institution'),
        const SizedBox(height: 20),
      ],
    );
  }
}
