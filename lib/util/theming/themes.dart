import 'package:flutter/material.dart';

///Themes
class Themes {
  ///Light Mode
  static ThemeData light() {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAFAFA),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFFFFFFFF),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFE4E5E6),
      ),
    );
  }

  ///Dark Mode
  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF131313),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      backgroundColor: const Color(0xFF121212),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF4E4376),
      ),
    );
  }
}
