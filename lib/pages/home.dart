import 'package:awesome_dialog/awesome_dialog.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Carousel Controller
    CarouselController carouselController = CarouselController();

    //Infinite Scroll
    bool? infiniteScroll = LocalData.retrieveData(
          context: context,
          box: "preferences",
          itemID: "infinite_scroll",
        ) ??
        false;

    //Current Feed Orientation
    String? currentOrientation = LocalData.retrieveData(
      context: context,
      box: "preferences",
      itemID: "orientation",
    );

    Axis parseOrientation({required String orientation}) {
      if (orientation == "vertical") {
        return Axis.vertical;
      } else if (orientation == "horizontal") {
        return Axis.horizontal;
      } else {
        return Axis.horizontal;
      }
    }

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
            "Bombando",
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: false,
          actions: [
            infiniteScroll == false
                ? IconButton(
                    onPressed: () async {
                      await carouselController.animateToPage(0);
                    },
                    tooltip: "Voltar ao Início",
                    icon: const Icon(Ionicons.return_up_back),
                  )
                : Container(),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Settings(),
                  ),
                ).then((_) => setState(() {}));
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
                final audioItem = snapshot.data!;

                return Column(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          height: double.infinity,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: infiniteScroll ?? false,
                          scrollDirection: parseOrientation(
                            orientation: currentOrientation ?? "vertical",
                          ),
                        ),
                        items: audioItem.entries.map(
                          (item) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                10.0,
                                20.0,
                                10.0,
                                20.0,
                              ),
                              child: AudioButton(
                                name: item.value.audioName,
                                url: item.value.audioURL,
                              ),
                            );
                          },
                        ).toList(),
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
