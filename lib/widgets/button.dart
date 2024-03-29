import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/util/permissions/permissions_management.dart';
import 'package:flutter/material.dart';
import 'package:ringtone_set/ringtone_set.dart';
import 'package:bombando/util/audio/manager.dart';

///Buttons
class Buttons {
  ///Default Use Button
  static Widget useButton({
    required BuildContext context,
    required String audioURL,
    required String usageTitle,
  }) {
    return ElevatedButton(
      onPressed: () async {
        bool permissionGranted =
            await PermissionsManagement.checkWriteSettingsPermission(
          context: context,
        );

        if (permissionGranted) {
          if (usageTitle == "Toque de Chamada") {
            //Ringtone
            await RingtoneSet.setRingtoneFromNetwork(
              "https://www.myinstants.com/${AudioPlayerManager.extractAudioURL(
                audioHTML: audioURL,
              )}.mp3",
            ).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Toque Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Erro ao Definir Toque",
                  );
                  Navigator.pop(context);
                }
              },
            );
          } else if (usageTitle == "Notificação") {
            //Notifications
            await RingtoneSet.setNotificationFromNetwork(
              "https://www.myinstants.com/${AudioPlayerManager.extractAudioURL(
                audioHTML: audioURL,
              )}.mp3",
            ).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Som de Notificação Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Erro ao Definir Som de Notificação",
                  );
                  Navigator.pop(context);
                }
              },
            );
          } else if (usageTitle == "Alarme") {
            //Alarm
            await RingtoneSet.setAlarmFromNetwork(
              "https://www.myinstants.com/${AudioPlayerManager.extractAudioURL(
                audioHTML: audioURL,
              )}.mp3",
            ).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Som de Alarme Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
                    toastType: ToastType.success,
                    title: "Feito!",
                    message: "Erro ao Definir Som de Alarme",
                  );
                  Navigator.pop(context);
                }
              },
            );
          }
        }
      },
      child: Text(usageTitle),
    );
  }

  ///Use Audio Button
  static Widget useAudio({
    required BuildContext context,
    required String audioURL,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
      ),
      onPressed: () async {
        //Ask User Input
        showModalBottomSheet(
          backgroundColor: const Color(0xFFFFFFFF),
          context: context,
          builder: (context) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Utilizar Som",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Podes definir este som como qualquer uma das seguintes opções:",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          useButton(
                            context: context,
                            audioURL: "${Web.audioURL}/$audioURL.mp3",
                            usageTitle: "Toque de Chamada",
                          ),
                          useButton(
                            context: context,
                            audioURL: "${Web.audioURL}/$audioURL.mp3",
                            usageTitle: "Notificação",
                          ),
                          useButton(
                            context: context,
                            audioURL: "${Web.audioURL}/$audioURL.mp3",
                            usageTitle: "Alarme",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Text("Utilizar"),
    );
  }
}
