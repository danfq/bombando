///Audio Model
class AudioFile {
  AudioFile({
    required this.audioName,
    required this.audioURL,
  });

  final String audioName;
  final String audioURL;

  Map<String, dynamic> toJSON() {
    return {
      "audioName": audioName,
      "audioURL": audioURL,
    };
  }

  factory AudioFile.fromJSON(Map<String, dynamic> json) {
    return AudioFile(
      audioName: json["name"],
      audioURL: json["url"],
    );
  }
}
