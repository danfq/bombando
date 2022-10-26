import 'package:bombando/util/audio/audio.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Status Bar & Navigation Bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFFFFFF),
        statusBarColor: Color(0xFFFAFAFA),
      ),
    );

    String extractAudioURL({required String audioHTML}) {
      final startIndex = audioHTML.indexOf("play('");
      final endIndex = audioHTML.indexOf(
        ".mp3',",
        startIndex + "play('".length,
      );

      return audioHTML.substring(startIndex + "play('".length, endIndex);
    }

    //App
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        title: const Text(
          "Bombando em Portugal",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: FutureBuilder(
          future: Web.audioMap(),
          builder: (context, AsyncSnapshot<Map<int, AudioFile>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final audioItem = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () => {
                        //Play Audio from URL
                        Audio.playFromURL(
                          url: extractAudioURL(
                            audioHTML: audioItem[index]!.audioURL,
                          ),
                        ),

                        //Notify User
                        Toasts.show(
                          context: context,
                          message: "A Tocar: ${audioItem[index]!.audioName}",
                        )
                      },
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  audioItem[index]!.audioName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Buttons.downloadAudio(
                                  context: context,
                                  audioURL: extractAudioURL(
                                    audioHTML: audioItem[index]!.audioURL,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
