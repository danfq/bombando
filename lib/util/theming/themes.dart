import 'package:flutter/material.dart';

///Themes
class Themes {
  ///Light Mode
  static ThemeData light() {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFEFD),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }

  ///Dark Mode
  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF131313),
      ),
      scaffoldBackgroundColor: const Color(0xFF0D2350),
      backgroundColor: const Color(0xFF0D2350),
    );
  }
}
