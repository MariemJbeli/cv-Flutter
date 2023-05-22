// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": Icon(Icons.home, color: Colors.blue),
      "route": "/home"
    },
    {
      "title": "Meteo",
      "icon": Icon(Icons.sunny_snowing, color: Colors.blue),
      "route": "/meteo"
    },
    {
      "title": "Galleries",
      "icon": Icon(Icons.photo, color: Colors.blue),
      "route": "/gallerie"
    },
    {
      "title": "Pays",
      "icon": Icon(Icons.location_city, color: Colors.blue),
      "route": "/pays"
    },
    {
      "title": "Contact",
      "icon": Icon(Icons.contact_page, color: Colors.blue),
      "route": "/contact"
    },
    {
      "title": "Paramétres",
      "icon": Icon(Icons.settings, color: Colors.blue),
      "route": "/para"
    },
    {
      "title": "Déconnexion",
      "icon": Icon(Icons.logout, color: Colors.blue),
      "route": "/authentification"
    },
  ];
}
