import 'package:bombando/util/audio/model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

///Web Data from MyInstants Website
class Web {
  ///MyInstants PT URLs
  static const url = "https://www.myinstants.com/pt/index/pt";
  static const audioURL = "https://www.myinstants.com";

  ///Page Content
  static Future<String> content() async {
    //Request
    final request = await http.get(
      Uri.parse(url),
    );

    //Remove Ads
    final String adFreeContent = request.body.replaceAll(
      '<div class="multiaspect-banner-ad mt-2 mb-4">',
      "",
    );

    //Return Content
    return adFreeContent;
  }

  ///Sound DIVs
  static Future<Map<int, AudioFile>> audioMap() async {
    final webPage = parse(await content());

    final audioList = webPage
        .getElementsByClassName("small-button")
        .map((sound) => sound.attributes["onclick"])
        .toList();

    final audioNames = webPage
        .getElementsByClassName("instant-link link-secondary")
        .map((sound) => sound.innerHtml)
        .toList();

    //Add Audios to Final List
    final audioMap = <int, AudioFile>{};

    for (var audioIndex = 0; audioIndex < audioList.length; audioIndex++) {
      //Check for Ukranian Meme
      if (!audioNames[audioIndex].contains("ucrania")) {
        audioMap.addAll({
          audioIndex: AudioFile(
            audioName: audioNames[audioIndex],
            audioURL: audioList[audioIndex]!,
          ),
        });
      }
    }

    return audioMap;
  }
}

///URLs
class URLs {
  ///Launch External URL
  static void launch({
    required String url,
  }) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
