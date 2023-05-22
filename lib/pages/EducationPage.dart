import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EducationItem(
                year: 'En Cours',
                institution:
                    'Mastère Professionnel En Développement Des Systèmes Informatiques Et Réseaux(DSIR)',
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
              // Add more EducationItem widgets for other education details
            ],
          ),
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
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
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
    );
  }
}
