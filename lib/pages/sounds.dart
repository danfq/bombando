import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/material.dart';

class Sounds extends StatelessWidget {
  const Sounds({super.key, required this.listController});

  ///List Controller
  final ScrollController listController;

  @override
  Widget build(BuildContext context) {
    //Audio Items
    final List audioItems = LocalStorage.boxData(box: "sounds")?["list"] ?? [];

    //UI
    return ListView.builder(
      controller: listController,
      physics: const BouncingScrollPhysics(),
      itemCount: audioItems.length,
      itemBuilder: (context, index) {
        //Audio Item
        final audio = AudioFile.fromJSON(audioItems[index]);

        return AudioButton(
          name: audio.audioName,
          url: audio.audioURL,
        );
      },
    );
  }
}
