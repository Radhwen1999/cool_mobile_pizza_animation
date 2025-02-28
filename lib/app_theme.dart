import 'package:flutter/material.dart';

/// You can store your color constants here:
const Color primaryDarkColor = Color(0xFF1E1E1E);
const Color primaryOrangeColor = Color(0xFFFF7300);
const Color primaryTextColor = Color(0xFF1A2023);

/// This is the custom background color you want to use for the entire app.
const Color scaffoldBackground = Color(0xFFF7F9F9);

const TextStyle paragraphTextStyle = TextStyle(
  color: Color(0xFF868686),
  fontSize: 14,
);

const TextStyle activatedPizzaButton = TextStyle(
  color: primaryOrangeColor,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: scaffoldBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: scaffoldBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: primaryOrangeColor),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: primaryTextColor,
    ),
  ),

);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: primaryDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryDarkColor,
    elevation: 0,
    iconTheme: IconThemeData(color: primaryOrangeColor),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);
