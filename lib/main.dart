import 'package:flutter/material.dart';
import 'package:flutterauth3/pages/Home.page.dart';
import 'package:flutterauth3/pages/authentification.page.dart';
import 'package:flutterauth3/pages/inscription.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> prefsSnapshot) {
                if (prefsSnapshot.hasData) {
                  final prefs = prefsSnapshot.data!;
                  final bool isConnected = prefs.getBool('connecte') ?? false;
                  if (isConnected) {
                    return HomePage();
                  } else {
                    return AuthentificationPage();
                  }
                } else {
                  return Container();
                }
              },
            ),
        '/home': (context) => HomePage(),
        '/inscription': (context) => InscriptionPage(),
        '/authentification': (context) => AuthentificationPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
