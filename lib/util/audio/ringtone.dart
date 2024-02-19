import 'package:flutter/material.dart';
import 'package:ringtone_set/ringtone_set.dart';

///Ringtone Manager
class RingtoneManager {
  ///Context
  BuildContext context;

  ///Ringtone Manager
  RingtoneManager(this.context);

  ///Set Ringtone via URL
  Future<void> setByURL({required String url}) async {
    //Ask User Which Type to Set
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        //Choices
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Title
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Definir Como:",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),

              //Ringtone
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await RingtoneSet.setRingtoneFromNetwork(url);
                    },
                    child: const Text("Toque de Chamada"),
                  ),
                ),
              ),

              //Notification
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await RingtoneSet.setNotificationFromNetwork(url);
                    },
                    child: const Text("Toque de Notificação"),
                  ),
                ),
              ),

              //Alarm
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await RingtoneSet.setAlarmFromNetwork(url);
                    },
                    child: const Text("Toque de Alarme"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
