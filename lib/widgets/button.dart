import 'package:bombando/util/audio/audio.dart';
import 'package:bombando/util/audio/download.dart';
import 'package:flutter/material.dart';
import 'package:folder_file_saver/folder_file_saver.dart';

///Buttons
class Buttons {
  ///Download Audio Button
  static Widget downloadAudio({
    required String audioURL,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
      ),
      onPressed: () {
        //Download Audio File to App Folder
        Download.audioCustomDirectory(
          audioURL: audioURL,
          fileDirectory: "/storage/emulated/0/Bombando/",
        );
      },
      child: const Text("Transferir"),
    );
  }
}
