import 'package:bombando/util/data/web.dart';
import 'package:just_audio/just_audio.dart';

///Audio Utilities
class Audio {
  ///Play from URL
  static Future<void> playFromURL({required String url}) async {
    //Audio Player
    final audioPlayer = AudioPlayer();

    //Set URL - Website URL + Audio URL
    await audioPlayer.setUrl("${Web.audioURL}/$url.mp3");

    //Play Audio
    await audioPlayer.play();

    //Stop Audio
    await audioPlayer.stop();
  }
}
