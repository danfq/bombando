import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ringtone_set/ringtone_set.dart';

///Buttons
class Buttons {
  ///Default Use Button
  static Widget useButton({
    required BuildContext context,
    required String audioURL,
    required String usageTitle,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
      ),
      onPressed: () async {
        bool permissionGranted = true;

        if (permissionGranted) {
          if (usageTitle == "Toque de Chamada") {
            //Ringtone
            await RingtoneSet.setRingtoneFromNetwork(audioURL).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    message: "Toque Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
                    message: "Erro ao Definir Toque",
                  );
                  Navigator.pop(context);
                }
              },
            );
          } else if (usageTitle == "Notificação") {
            //Notifications
            await RingtoneSet.setNotificationFromNetwork(audioURL).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    message: "Som de Notificação Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
                    message: "Erro ao Definir Som de Notificação",
                  );
                  Navigator.pop(context);
                }
              },
            );
          } else if (usageTitle == "Alarme") {
            //Alarm
            await RingtoneSet.setAlarmFromNetwork(audioURL).then(
              (isSet) {
                if (isSet) {
                  Toasts.show(
                    context: context,
                    message: "Som de Alarme Definido!",
                  );
                  Navigator.pop(context);
                } else {
                  Toasts.show(
                    context: context,
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
