import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Theme Controller
class ThemeController {
  ///Current Theme
  static bool current({required BuildContext context}) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  ///Set Appearance Mode
  static void setAppearance({
    required BuildContext context,
    required bool mode,
  }) {
    mode ? setDark(context: context) : setLight(context: context);
  }

  ///Set Dark Mode
  static void setDark({
    required BuildContext context,
  }) {
    AdaptiveTheme.of(context).setDark();
  }

  ///Set Light Mode
  static void setLight({
    required BuildContext context,
  }) {
    AdaptiveTheme.of(context).setLight();
  }

  ///Easy Toggle Mode
  static void easyToggle({
    required BuildContext context,
  }) {
    AdaptiveTheme.of(context).toggleThemeMode();
  }

  //Status Bar & Navigation Bar
  static void statusAndNav({required AdaptiveThemeMode mode}) {
    if (mode == AdaptiveThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFFFFFFFF),
          statusBarColor: Color(0xFFFFFEFD),
        ),
      );
    } else if (mode == AdaptiveThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF0D2350),
          statusBarColor: Color(0xFF131313),
        ),
      );
    }
  }
}
