import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bombando/util/theming/controller.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: AdaptiveTheme.getThemeMode(),
          builder: (context, snapshot) {
            return SettingsList(
              physics: const BouncingScrollPhysics(),
              sections: [
                SettingsSection(
                  title: const Text("Appearance"),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      initialValue: (snapshot.data == AdaptiveThemeMode.light)
                          ? false
                          : true,
                      onToggle: (mode) {
                        setState(() {
                          ThemeController.setAppearance(
                            context: context,
                            mode: mode,
                          );
                        });
                      },
                      leading:
                          (Theme.of(context).brightness == Brightness.light)
                              ? const Ikonate(Ikonate.sun)
                              : const Ikonate(Ikonate.moon),
                      title: Text(
                        (Theme.of(context).brightness == Brightness.light)
                            ? "Light Mode"
                            : "Dark Mode",
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
