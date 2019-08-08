import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'PokemonSayfa.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "there is a house in cahrming  town",
      //home: Sorular() OPENTDB saydası,
      home: PokemonSayfasi(),
    );
  }
}
