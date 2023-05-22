// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../menu/drawer.wedget.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Contact"),
        ),
        body: Center(
          child: Text("Page Contact", style: TextStyle(fontSize: 22)),
        ));
  }
}
