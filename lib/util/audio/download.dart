import 'dart:io';
import 'package:bombando/util/notifications/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

///Download Utilities
class Download {
  ///Save Audio
  static Future<File?> saveAudio({
    required BuildContext context,
    required String audioName,
    required String audioURL,
    required String fileDirectory,
  }) async {
    //Sharable File
    File fileToShare;

    //Check Permission
    try {
      //Storage Permission
      final status = await Permission.storage.status;

      if (status.isDenied) {
        //Request Permission
        await Permission.storage.request();
      } else {
        //Download Audio
        var response = await Dio().get(
          audioURL,
          options: Options(responseType: ResponseType.bytes),
        );

        //Write Bytes to File
        File audioFile = File(
          "$fileDirectory/$audioName.mp3",
        );

        fileToShare = await audioFile.writeAsBytes(response.data);

        //Return File
        return fileToShare;
      }
    } catch (error) {
      Toasts.show(
        context: context,
        toastType: ToastType.error,
        title: "Erro",
        message: error.toString(),
      );
    }
    return null;
  }
}
