import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/util/data/web.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

///Download Utilities
class Download {
  static String currentProgress = "0";
  static bool isLoading = false;

  static final ioOperator = Dio();

  ///Download Audio to Custom Directory
  static Future<void> audioCustomDirectory({
    required BuildContext context,
    required String audioURL,
    required String fileDirectory,
  }) async {
    //Check Permission
    try {
      //Storage Permission
      final status = await Permission.storage.status;

      if (status.isDenied) {
        //Request Permission
        await Permission.storage.request();
        return;
      } else {
        isLoading = true;

        //Save Audio
        await saveAudio(
          context: context,
          audioURL: audioURL,
          fileDirectory: fileDirectory,
        );
      }
    } catch (error) {
      Toasts.show(
        context: context,
        message: error.toString(),
      );
    } finally {
      isLoading = false;
    }
  }

  ///Save Audio
  static Future<void> saveAudio({
    required BuildContext context,
    required String audioURL,
    required String fileDirectory,
  }) async {
    final file = "$fileDirectory/$audioURL.mp3";

    await ioOperator.download("${Web.audioURL}/$audioURL.mp3", file,
        onReceiveProgress: (current, total) {
      currentProgress = "${((current / total) * 100).toStringAsFixed(0)}%";

      Toasts.show(
        context: context,
        message: "Progresso: ${((current / total) * 100).toStringAsFixed(0)}%",
      );
    });
  }
}
