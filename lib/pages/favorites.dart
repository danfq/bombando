import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    //Favorites
    final favorites = LocalStorage.boxData(box: "favorites")?["list"] ?? [];

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
                  return AudioButton(
                    name: audio.audioName,
                    url: audio.audioURL,
                    showFavorite: false,
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
