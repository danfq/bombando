import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/material.dart';

class Sounds extends StatelessWidget {
  const Sounds({super.key, required this.listController});

  ///List Controller
  final ScrollController listController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                    final audio = audioItems.entries.elementAt(index).value;

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
    );
  }
}
