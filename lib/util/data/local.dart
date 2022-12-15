import 'package:bombando/util/notifications/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

///Local Data
class LocalData {
  ///Open Box by Name or All if Unspecified
  static Future<void> openBoxes({String? box}) async {
    //Documents Folder
    final documentsFolder = await getApplicationDocumentsDirectory();
    Hive.initFlutter(documentsFolder.path);

    //Boxes
    final boxes = [
      "preferences",
    ];

    //Unspecified Box - Open All
    if (box == null) {
      for (var box in boxes) {
        await Hive.openBox(
          box,
          path: "${documentsFolder.path}/BombandoData",
        );
      }
    } else {
      //Box Specified - Open Box
      Hive.openBox(box);
    }
  }

  ///Save Data
  static Future<void> saveData({
    required BuildContext context,
    required String box,
    required Map<String, String> data,
  }) async {
    //Check if Box is Open
    if (Hive.isBoxOpen(box)) {
      //Box is Open - Save Data
      await Hive.box(box).putAll(data);
    } else {
      //Attempt to Open Box
      try {
        //Open Box
        Hive.openBox(
          box,
        );

        //Save Data
        await Hive.box(box).putAll(data);
      } on HiveError catch (error) {
        //Notify User
        Toasts.show(
          context: context,
          message: error.message,
        );
      }
    }
  }

  ///Retrieve Data by setName & itemID
  static dynamic retrieveData({
    required BuildContext context,
    required String box,
    required String itemID,
  }) {
    //Check if Box is Open
    if (Hive.isBoxOpen(box)) {
      print(Hive.box(box).get(itemID));
      //Box is Open - Get Data
      return Hive.box(box).get(itemID);
    } else {
      try {
        //Get Data
        return Hive.box(box).get(itemID);
      } on HiveError catch (error) {
        //Notify User
        Toasts.show(
          context: context,
          message: error.message,
        );
      }
    }
  }
}
