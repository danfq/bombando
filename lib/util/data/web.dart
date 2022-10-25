import 'package:bombando/util/audio/model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

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

    //Return Content
    return request.body;
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
      audioMap.addAll({
        audioIndex: AudioFile(
          audioName: audioNames[audioIndex],
          audioURL: audioList[audioIndex]!,
        ),
      });
    }

    return audioMap;
  }
}
