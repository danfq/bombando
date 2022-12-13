import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/util/audio/audio.dart';
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
    return InkWell(
      onTap: () => Audio.playFromURL(url: url),
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(name),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
