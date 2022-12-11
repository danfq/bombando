import 'package:bombando/pages/settings.dart';
import 'package:bombando/util/audio/audio.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icony/icony_ikonate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //App
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bombando em Portugal",
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Ikonate(
                Ikonate.settings,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Web.audioMap(),
          builder: (context, AsyncSnapshot<Map<int, AudioFile>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              final audioItem = snapshot.data!;

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () => {
                        //Play Audio from URL
                        Audio.playFromURL(
                          url: Audio.extractAudioURL(
                            audioHTML: audioItem[index]!.audioURL,
                          ),
                        ),

                        //Notify User
                        Toasts.show(
                          context: context,
                          message: "A Tocar: ${audioItem[index]!.audioName}",
                        )
                      },
                      child: PrettyButtons.audio(
                        context: context,
                        name: audioItem[index]!.audioName,
                        url: audioItem[index]!.audioURL,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
