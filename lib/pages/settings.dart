import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/pages/home.dart';
import 'package:bombando/pages/team.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/util/theming/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definições"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: AdaptiveTheme.getThemeMode(),
          builder: (context, snapshot) {
            return SettingsList(
              physics: const BouncingScrollPhysics(),
              lightTheme: SettingsThemeData(
                settingsListBackground:
                    Theme.of(context).scaffoldBackgroundColor,
              ),
              darkTheme: SettingsThemeData(
                settingsListBackground:
                    Theme.of(context).scaffoldBackgroundColor,
              ),
              sections: [
                SettingsSection(
                  title: const Text("Visual"),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      initialValue: ThemeController.current(context: context),
                      onToggle: (mode) {
                        ThemeController.setAppearance(
                          context: context,
                          mode: mode,
                        );
                      },
                      leading:
                          (Theme.of(context).brightness == Brightness.light)
                              ? const Icon(Ionicons.ios_sunny)
                              : const Icon(Ionicons.ios_moon),
                      title: Text(
                        (Theme.of(context).brightness == Brightness.light)
                            ? "Modo Claro"
                            : "Modo Escuro",
                      ),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text("Equipa e Licenças"),
                  tiles: [
                    SettingsTile.navigation(
                      title: const Text("Equipa"),
                      leading: const Icon(Ionicons.ios_people),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Team(),
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: const Text("Licenças"),
                      leading: const Icon(Ionicons.ios_document_outline),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LicensePage(
                              applicationName: "Bombando",
                              applicationIcon: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  ThemeController.current(context: context)
                                      ? "assets/images/logo_no_background_dark.png"
                                      : "assets/images/logo_no_background.png",
                                  height: 100.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
