import 'package:bombando/util/audio/download.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

///Buttons
class Buttons {
  ///Download Audio Button
  static Widget downloadAudio({
    required BuildContext context,
    required String audioURL,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
      ),
      onPressed: () async {
        final directory = await path_provider.getExternalStorageDirectory();

        //Download Audio File to App Folder
        Download.audioCustomDirectory(
          context: context,
          audioURL: audioURL,
          fileDirectory: "${directory!.path}/Bombando/",
        );
      },
      child: const Text("Transferir"),
    );
  }
}
