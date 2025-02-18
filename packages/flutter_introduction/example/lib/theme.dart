import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF71C6D1);

ThemeData theme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: const Color(0xFFFAF9F6),
  fontFamily: "Merriweather",
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 24,
      color: Color(0xFF71C6D1),
    ),
    bodyMedium: TextStyle(
      fontFamily: "Avenir",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black,
    ),
  ),
);
