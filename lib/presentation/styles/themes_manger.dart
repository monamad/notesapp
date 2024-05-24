import 'package:flutter/material.dart';

abstract class ThemesManager {
  static ThemeData appTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      hintColor: Colors.blueAccent,
    );
  }
}
