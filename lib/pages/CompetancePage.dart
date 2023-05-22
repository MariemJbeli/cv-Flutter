import 'package:flutter/material.dart';

class CompetancePage extends StatelessWidget {
  final List<String> skills = [
    'Laravel',
    'JavaScript',
    'React',
    'Angular',
    'Vue.js',
    'mongodb',
    'mysql',
    'Express.js',
    'Tailwind CSS',
    'Bootstrap'
  ];

  final List<String> skillImages = [
    'images/laravel.png',
    'images/js.png',
    'images/reactjs.png',
    'images/angular.png',
    'images/vuejs.png',
    'images/mongodb.png',
    'images/mysql.png',
    'images/express.png',
    'images/tailwindcss.png',
    'images/bootstrap.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      Image.asset(
                        skillImages[index],
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        skills[index],
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
