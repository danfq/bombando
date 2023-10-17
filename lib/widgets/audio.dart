import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bombando/util/audio/manager.dart';
import 'package:bombando/util/audio/share.dart';
import 'package:bombando/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bombando/util/data/web.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({
    super.key,
    required this.name,
    required this.url,
  });

  ///Audio Name
  final String name;

  ///Audio URL
  final String url;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  ///Playing Status
  bool playing = false;

  ///Get Playing Status
  Future<void> getPlayingStatus() async {
    playing = await AudioPlayerManager.checkIfPlaying(playerID: widget.name);
  }

  @override
  void initState() {
    super.initState();

    //Playing Status
    getPlayingStatus();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () async {
        if (playing) {
          await AudioPlayerManager.stopPlayer(playerID: widget.name);
        } else {
          //Audio Player
          final player = await AudioPlayerManager.playFromURL(
            name: widget.name,
            url: AudioPlayerManager.extractAudioURL(audioHTML: widget.url),
          );

          //On Complete
          player.onPlayerStateChanged.listen((state) {
            if (state != PlayerState.playing) {
              setState(() {
                playing = false;
              });
            }
          });
        }

        setState(() {
          playing = !playing;
        });
      },
      child: Card(
        elevation: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Image.asset(
                    "assets/images/audio_background.png",
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        playing ? const MiniMusicVisualizer() : Container(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            child: const Icon(CupertinoIcons.square_list),
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.noHeader,
                                body: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        audioURL: widget.url,
                                        usageTitle: "Toque de Chamada",
                                      ),
                                      Buttons.useButton(
                                        context: context,
                                        audioURL: widget.url,
                                        usageTitle: "Notificação",
                                      ),
                                      Buttons.useButton(
                                        context: context,
                                        audioURL: widget.url,
                                        usageTitle: "Alarme",
                                      ),
                                    ],
                                  ),
                                ),
                              ).show();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            child: const Icon(CupertinoIcons.share),
                            onPressed: () {
                              ShareAudio.downloadAndShare(
                                context: context,
                                audioName: widget.name,
                                audioURL:
                                    "${Web.audioURL}${AudioPlayerManager.extractAudioURL(audioHTML: widget.url)}.mp3",
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
