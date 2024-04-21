import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bombando/pages/home.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/util/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  //Ensure Binding is Initialized
  WidgetsFlutterBinding.ensureInitialized();

  //Open Boxes
  await LocalStorage.init();

  //Run App
  runApp(
    AdaptiveTheme(
      light: Themes.light(),
      dark: Themes.dark(),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) {
        return GetMaterialApp(
          theme: light,
          darkTheme: dark,
          home: const Home(),
        );
      },
    ),
  );
}
