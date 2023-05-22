import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/ismahen.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'Ismahen abdallah',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at urna sit amet nulla euismod cursus. Fusce sagittis massa vitae massa porta interdum. In id enim sapien. Suspendisse viverra, ex sed viverra luctus, mi ligula dapibus tellus, sit amet convallis nibh risus ac libero. Vivamus mattis nisi non turpis varius varius. Aenean eleifend, sem eu bibendum pharetra, erat arcu fringilla felis, in scelerisque lacus dui vel neque. Sed iaculis leo ut elit tempus sagittis. Curabitur posuere est sit amet consectetur tristique. Duis vitae ullamcorper turpis.',
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
