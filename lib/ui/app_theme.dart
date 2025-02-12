import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Colors.black;
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Colors.white70;
  static const Color accentColor = Colors.greenAccent;

  static const TextStyle clockTextStyle = TextStyle(
    color: textColor,
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dateTextStyle = TextStyle(
    color: textColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleTextStyle = TextStyle(
    color: textColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    color: secondaryTextColor,
    fontSize: 18,
  );

  static const TextStyle infoTextStyle = TextStyle(
    color: Colors.white54,
    fontSize: 16,
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 9, 237, 127),
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}