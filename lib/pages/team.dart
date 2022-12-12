import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipa"),
      ),
      body: SafeArea(
        child: SettingsList(
          physics: const BouncingScrollPhysics(),
          sections: [
            SettingsSection(
              title: const Text("Programadores"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Ikonate(Ikonate.code),
                  title: const Text("DanFQ"),
                  onPressed: (context) {
                    launchUrl(
                      Uri.parse(
                        "https://github.com/danfq",
                      ),
                    );
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text("Design"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Ikonate(Ikonate.pen),
                  title: const Text("VEIGA"),
                  onPressed: (context) {
                    launchUrl(
                      Uri.parse(
                        "https://www.instagram.com/nerdyy_pics",
                      ),
                    );
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text("Testes de Qualidade"),
              tiles: [
                SettingsTile.navigation(
                  leading: const Ikonate(Ikonate.trending_up),
                  title: const Text("MatiFF"),
                  onPressed: (context) {
                    launchUrl(
                      Uri.parse(
                        "https://www.instagram.com/tide_ff",
                      ),
                    );
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
