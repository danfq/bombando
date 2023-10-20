import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/pages/favorites.dart';
import 'package:bombando/pages/settings.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:icony/icony_ikonate.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    ///List Controller
    ScrollController listController = ScrollController();

    //App
    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          desc: "Tens a certeza que queres sair?",
          btnOk: ElevatedButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text("Sair"),
          ),
          btnCancel: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          dialogType: DialogType.question,
        ).show();

        //Prevent Exit
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Bombando",
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () async {
                await listController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceInOut,
                );
              },
              tooltip: "Voltar ao Início",
              icon: const Icon(Ionicons.return_up_back),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Favorites(),
                  ),
                );
              },
              tooltip: "Favoritos",
              icon: const Icon(Ionicons.ios_heart_outline),
            ),
            IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              tooltip: "Definições",
              icon: const Icon(Ionicons.ios_settings_outline),
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: Web.audioMap(),
            builder: (context, AsyncSnapshot<Map<int, AudioFile>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                final audioItems = snapshot.data!;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: listController,
                        itemCount: audioItems.entries.length,
                        itemBuilder: (context, index) {
                          //Audio Item
                          final audio =
                              audioItems.entries.elementAt(index).value;

                          return AudioButton(
                            name: audio.audioName,
                            url: audio.audioURL,
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
