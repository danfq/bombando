import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';

///Toasts
class Toasts {
  ///Show with Custom Message
  static Future<void> show({
    required BuildContext context,
    required String message,
  }) async {
    await showPlatformToast(
      context: context,
      child: Text(message),
    );
  }
}
