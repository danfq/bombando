import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/pages/settings.dart';
import 'package:bombando/util/audio/audio.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icony/icony_ikonate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            "Bombando em Portugal",
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Ikonate(
                  Ikonate.settings,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: Web.audioMap(),
            builder: (context, AsyncSnapshot<Map<int, AudioFile>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                final audioItem = snapshot.data!;

                return CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    initialPage: 0,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: snapshot.data!.entries.map(
                    (item) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PrettyButtons.audio(
                          context: context,
                          name: item.value.audioName,
                          url: item.value.audioURL,
                        ),
                      );
                    },
                  ).toList(),
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
