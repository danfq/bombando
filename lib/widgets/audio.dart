import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bombando/util/audio/manager.dart';
import 'package:bombando/util/audio/ringtone.dart';
import 'package:bombando/util/audio/share.dart';
import 'package:bombando/util/data/local.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/theming/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:pull_down_button/pull_down_button.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({
    Key? key,
    required this.name,
    required this.url,
    this.showFavorite = true,
  }) : super(key: key);

  final String name;
  final String url;
  final bool showFavorite;

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

  ///Audio URL
  String audioURL = "";

  ///Favorite Status
  bool favorite = false;

  @override
  void initState() {
    super.initState();

    //Set Audio URL
    audioURL = AudioPlayerManager.extractAudioURL(audioHTML: widget.url);

    //Get Playing Status
    getPlayingStatus();

    //Get Favorite Status
    final boxData = LocalStorage.boxData(box: "favorites");

    if (boxData != null && boxData.containsKey("list")) {
      final listMap = boxData["list"] as Map<dynamic, dynamic>;

      if (listMap.containsKey(widget.name)) {
        favorite = listMap[widget.name] != null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 14.0),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        leading: SizedBox(
          width: 20.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: playing
                ? const MiniMusicVisualizer()
                : Image.asset(
                    ThemeController.current(context: context)
                        ? "assets/images/logo_no_background_dark.png"
                        : "assets/images/logo_no_background.png",
                    width: 40.0,
                  ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Favorite
            Visibility(
              visible: widget.showFavorite,
              child: IconButton(
                onPressed: () async {
                  //Add or Remove from Favorites
                  if (favorite) {
                    //Remove Favorite
                    final boxData = LocalStorage.boxData(box: "favorites");

                    if (boxData != null && boxData.containsKey("list")) {
                      final listMap = boxData["list"] as Map<dynamic, dynamic>;

                      if (listMap.containsKey(widget.name)) {
                        //Remove from Favorites
                        listMap.remove(widget.name);

                        //Update Data
                        await LocalStorage.setData(
                          box: "favorites",
                          data: {"list": listMap},
                        );
                      }
                    }
                  } else {
                    //Add Favorite
                    final boxData = LocalStorage.boxData(box: "favorites");

                    Map<dynamic, dynamic> listMap = {};

                    if (boxData != null && boxData.containsKey("list")) {
                      listMap = boxData["list"] as Map<dynamic, dynamic>;
                    }

                    //Add Favorite
                    listMap[widget.name] = widget.url;

                    //Update Data
                    await LocalStorage.setData(
                      box: "favorites",
                      data: {"list": listMap},
                    );
                  }

                  //Update UI
                  setState(() {
                    favorite = !favorite;
                  });
                },
                icon: favorite
                    ? Icon(
                        Ionicons.ios_heart,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : const Icon(Ionicons.ios_heart_outline),
              ),
            ),

            //Extra Options
            PullDownButton(
              itemBuilder: (context) {
                return [
                  //Share
                  PullDownMenuItem(
                    onTap: () async {
                      await ShareAudio.downloadAndShare(
                        context: context,
                        audioName: widget.name,
                        audioURL: "${Web.audioURL}$audioURL.mp3",
                      );
                    },
                    icon: Ionicons.ios_share_outline,
                    title: "Share",
                  ),

                  //Set as Ringtone
                  PullDownMenuItem(
                    enabled: Platform.isAndroid,
                    onTap: () async {
                      await RingtoneManager(context).setByURL(
                        url: "${Web.audioURL}$audioURL.mp3",
                      );
                    },
                    icon: Ionicons.ios_phone_portrait_outline,
                    title: "Set as Ringtone",
                  ),
                ];
              },
              buttonBuilder: (context, showMenu) {
                return IconButton(
                  onPressed: showMenu,
                  icon: const Icon(Ionicons.ios_ellipsis_vertical),
                );
              },
            ),
          ],
        ),
        onTap: () async {
          if (playing) {
            await AudioPlayerManager.stopPlayer(playerID: widget.name);
          } else {
            //Audio Player
            final player = await AudioPlayerManager.playFromURL(
              name: widget.name,
              url: audioURL,
            );

            //On Complete
            player.onPlayerStateChanged.listen((state) {
              if (state != PlayerState.playing) {
                if (mounted) {
                  setState(() {
                    playing = false;
                  });
                }
              }
            });
          }

          setState(() {
            playing = !playing;
          });
        },
      ),
    );
  }
}
