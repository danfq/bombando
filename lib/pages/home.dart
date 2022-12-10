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
