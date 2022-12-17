import 'package:bombando/util/notifications/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

///Permissions Management
class PermissionsManagement {
  ///Check WRITE_SETTINGS Permission
  static Future<bool> checkWriteSettingsPermission({
    required BuildContext context,
  }) async {
    //Kotlin Platform
    var kotlinPlatform = const MethodChannel("flutter.native/helper");

    //Get Permission
    bool currentStatus = false;

    try {
      final status = await kotlinPlatform.invokeMethod(
        "checkSystemWritePermission",
      );

      currentStatus = status;
    } on PlatformException catch (error) {
      //Notify User
      Toasts.show(
        context: context,
        toastType: ToastType.error,
        title: "Erro",
        message: error.message ?? "An Error Has Occurred",
      );
    }

    //Return Permission Status
    return currentStatus;
  }
}
