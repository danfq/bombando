import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //Favorites
  final Map favorites = LocalStorage.boxData(box: "favorites")?["list"] ?? {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: favorites.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  //Audio
                  final audio = AudioFile(
                    audioName: favorites.entries.elementAt(index).key,
                    audioURL: favorites.entries.elementAt(index).value,
                  );

                  //UI
                  return GestureDetector(
                    onLongPress: () async {
                      //Confirm Removal from Favorites
                      await Get.defaultDialog(
                        titlePadding: const EdgeInsets.all(20.0),
                        title: "Remover dos Favoritos?",
                        content: const Text("Tens a certeza?"),
                        cancel: TextButton(
                          onPressed: () => Get.back(),
                          child: const Text("Cancelar"),
                        ),
                        confirm: ElevatedButton(
                          onPressed: () async {
                            //Remove from List
                            setState(() {
                              favorites.remove(
                                favorites.entries.elementAt(index).key,
                              );
                            });

                            //Update Favorites
                            await LocalStorage.setData(
                              box: "favorites",
                              data: {"list": favorites},
                            );

                            //Close Dialog
                            Get.back();
                          },
                          child: const Text("Confirmar"),
                        ),
                      );
                    },
                    child: AudioButton(
                      name: audio.audioName,
                      url: audio.audioURL,
                      showFavorite: false,
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Não Tens Favoritos"),
              ),
      ),
    );
  }
}
