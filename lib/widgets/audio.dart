import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Pretty Buttons
class PrettyButtons {
  ///Audio Button
  static Widget audio({
    required BuildContext context,
    required String name,
    required String url,
  }) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: const Icon(CupertinoIcons.square_list),
          onPressed: () {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.noHeader,
              body: Container(
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
                      Buttons.useButton(
                        context: context,
                        audioURL: url,
                        usageTitle: "Toque de Chamada",
                      ),
                      Buttons.useButton(
                        context: context,
                        audioURL: url,
                        usageTitle: "Notificação",
                      ),
                      Buttons.useButton(
                        context: context,
                        audioURL: url,
                        usageTitle: "Alarme",
                      ),
                    ],
                  ),
                ),
              ),
            ).show();
          },
        ),
      ),
    );
  }
}
