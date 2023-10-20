import 'package:bombando/util/data/web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:settings_ui/settings_ui.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipa"),
      ),
      body: SafeArea(
        child: SettingsList(
          physics: const BouncingScrollPhysics(),
          lightTheme: SettingsThemeData(
            settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
          ),
          darkTheme: SettingsThemeData(
            settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
          ),
          sections: [
            SettingsSection(
              title: const Text("Programadores"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Ionicons.ios_code),
                  title: const Text("DanFQ"),
                  onPressed: (context) {
                    URLs.launch(url: "https://github.com/danfq");
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text("Design"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Ionicons.ios_brush),
                  title: const Text("VEIGA"),
                  onPressed: (context) {
                    URLs.launch(url: "https://www.instagram.com/veigadesigns");
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text("Testes de Qualidade"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(MaterialCommunityIcons.test_tube),
                  title: const Text("MatiFF"),
                  onPressed: (context) {
                    URLs.launch(url: "https://www.instagram.com/tide_ff");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
