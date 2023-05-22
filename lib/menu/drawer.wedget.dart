// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  //const MyDrawer({super.key});
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white, Colors.blue])),
            child: Center(
                child: CircleAvatar(
              backgroundImage: AssetImage("images/sp.jpeg"),
              radius: 80,
            )),
          ),
          ...(GlobalParams.menus as List).map((item) {
            return ListTile(
              title: Text("${item['title']}", style: TextStyle(fontSize: 18)),
              leading: item['icon'],
              trailing: Icon(Icons.arrow_right, color: Colors.blue),
              onTap: () async {
                if ('${item['title']}' != 'Déconnexion') {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, "${item['route']}");
                } else {
                  Deconnexion(context);
                }
              },
            );
          }),
          Divider(height: 3, color: Colors.blue),
        ],
      ),
    );
  }

  Future<void> Deconnexion(context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);

    Navigator.of(context).pushNamedAndRemoveUntil(
        '/authentification', (Route<dynamic> route) => false);
  }
}
