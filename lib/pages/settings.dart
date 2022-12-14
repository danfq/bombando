import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bombando/pages/home.dart';
import 'package:bombando/pages/team.dart';
import 'package:bombando/util/theming/controller.dart';
import 'package:flutter/cupertino.dart';
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
          "Definições",
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
                  title: const Text("Visual"),
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
                            ? "Modo Claro"
                            : "Modo Escuro",
                      ),
                    ),
                    SettingsTile.navigation(
                      onPressed: (context) {},
                      leading: const Ikonate(Ikonate.swap_vertical),
                      title: const Text("Orientação"),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text("Equipa e Licenças"),
                  tiles: [
                    SettingsTile.navigation(
                      title: const Text("Equipa"),
                      leading: const Ikonate(Ikonate.people),
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
                      leading: const Ikonate(Ikonate.lightbulb),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LicensePage(
                              applicationName: "Bombando",
                              applicationIcon: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  "assets/images/logo_no_background.png",
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
