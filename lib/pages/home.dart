import 'package:bombando/util/audio/audio.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/util/notifications/toast.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:bombando/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
              final audioItem = snapshot.data!;

              return GridView.custom(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.4,
                  crossAxisSpacing: 0.4,
                  pattern: [
                    const WovenGridTile(0.8),
                    const WovenGridTile(
                      2 / 2,
                      crossAxisRatio: 1,
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: snapshot.data!.length,
                  (context, index) {
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
                        onLongPress: () {
                          showModalBottomSheet(
                            backgroundColor: const Color(0xFFFFFFFF),
                            context: context,
                            builder: (context) {
                              return Container(
                                child: Padding(
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
                                      Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Column(
                                          children: [
                                            Buttons.useButton(
                                              context: context,
                                              audioURL:
                                                  "${Web.audioURL}/${Audio.extractAudioURL(
                                                audioHTML:
                                                    audioItem[index]!.audioURL,
                                              )}.mp3",
                                              usageTitle: "Toque de Chamada",
                                            ),
                                            Buttons.useButton(
                                              context: context,
                                              audioURL:
                                                  "${Web.audioURL}/${Audio.extractAudioURL(
                                                audioHTML:
                                                    audioItem[index]!.audioURL,
                                              )}.mp3",
                                              usageTitle: "Notificação",
                                            ),
                                            Buttons.useButton(
                                              context: context,
                                              audioURL:
                                                  "${Web.audioURL}/${Audio.extractAudioURL(
                                                audioHTML:
                                                    audioItem[index]!.audioURL,
                                              )}.mp3",
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
                        child: PrettyButtons.audio(
                          context: context,
                          name: audioItem[index]!.audioName,
                          url: audioItem[index]!.audioURL,
                        ),
                      ),
                    );
                  },
                ),
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
