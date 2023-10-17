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
                              ? const Icon(Ionicons.ios_sunny)
                              : const Icon(Ionicons.ios_moon),
                      title: Text(
                        (Theme.of(context).brightness == Brightness.light)
                            ? "Modo Claro"
                            : "Modo Escuro",
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(Ionicons.swap_vertical),
                      title: const Text("Orientação"),
                      onPressed: (context) {
                        showAdaptiveDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return Dialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Orientação da Lista de Memes",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await LocalData.saveData(
                                              context: context,
                                              box: "preferences",
                                              data: {
                                                "orientation": "vertical",
                                              },
                                            );

                                            //Notify User
                                            if (mounted) {
                                              Navigator.pop(context);

                                              Toasts.show(
                                                context: context,
                                                toastType: ToastType.success,
                                                title: "Feito!",
                                                message: "Orientação: Vertical",
                                              );
                                            }
                                          },
                                          child: const Text("Vertical"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await LocalData.saveData(
                                              context: context,
                                              box: "preferences",
                                              data: {
                                                "orientation": "horizontal",
                                              },
                                            );

                                            //Notify User
                                            if (mounted) {
                                              Navigator.pop(context);

                                              Toasts.show(
                                                context: context,
                                                toastType: ToastType.success,
                                                title: "Feito!",
                                                message:
                                                    "Orientação: Horizontal",
                                              );
                                            }
                                          },
                                          child: const Text("Horizontal"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SettingsTile.switchTile(
                      leading: const Icon(
                        Ionicons.ios_arrow_down_circle_outline,
                      ),
                      title: const Text("Lista Infinita"),
                      initialValue: (LocalData.retrieveData(
                            context: context,
                            box: "preferences",
                            itemID: "infinite_scroll",
                          )) ??
                          false,
                      onToggle: (mode) {
                        setState(() {
                          LocalData.saveData(
                            context: context,
                            box: "preferences",
                            data: {
                              "infinite_scroll": mode,
                            },
                          );
                        });
                      },
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
