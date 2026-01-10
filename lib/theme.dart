import 'package:flutter/material.dart';

class Themes {
  // light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 212, 210, 202),
  );

  // dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(255, 30, 30, 30),
  );
}
