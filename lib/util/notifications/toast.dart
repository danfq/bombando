import 'package:flutter/material.dart';

///Toasts
class Toasts {
  ///Show with Custom Message
  static void show({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
