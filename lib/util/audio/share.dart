import 'package:bombando/util/audio/download.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

///Share Audio
class ShareAudio {
  ///Download to Device & Share
  static Future<void> downloadAndShare({
    required BuildContext context,
    required String audioName,
    required String audioURL,
  }) async {
    final documents = await getApplicationDocumentsDirectory();

    //Download File
    final file = await Download.saveAudio(
      context: context,
      audioName: audioName,
      audioURL: audioURL,
      fileDirectory: documents.path,
    );

    //Check Downloaded File
    if (file != null) {
      //Share File
      // ignore: deprecated_member_use
      await Share.shareFiles([file.path], text: audioName);
    } else {
      //Invalid or Null File
      Toasts.show(
        context: context,
        toastType: ToastType.error,
        title: "Erro",
        message: "Erro ao Partilhar",
      );
    }
  }
}
