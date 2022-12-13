import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bombando/pages/home.dart';
import 'package:bombando/util/theming/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    AdaptiveTheme(
      light: Themes.light(),
      dark: Themes.dark(),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) {
        return MaterialApp(
          theme: light,
          darkTheme: dark,
          home: const Home(),
        );
      },
    ),
  );
}
