import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/screens/anime_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Season Guide - Your Companion for Seasonal Anime',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      home: const AnimeListScreen(),
    );
  }
}
