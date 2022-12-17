import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

///Toasts
class Toasts {
  ///Show with Custom Message
  static Future<void> show({
    required BuildContext context,
    required ToastType toastType,
    required String title,
    required String message,
  }) async {
    //Check Toast Type
    if (toastType == ToastType.info) {
      ElegantNotification.info(
        title: Text(title),
        description: Text(message),
        notificationPosition: NotificationPosition.bottomCenter,
        animation: AnimationType.fromBottom,
        background: Theme.of(context).scaffoldBackgroundColor,
      ).show(context);
    } else if (toastType == ToastType.error) {
      ElegantNotification.error(
        title: Text(title),
        description: Text(message),
        notificationPosition: NotificationPosition.bottomCenter,
        animation: AnimationType.fromBottom,
        background: Theme.of(context).scaffoldBackgroundColor,
      ).show(context);
    } else if (toastType == ToastType.success) {
      ElegantNotification.success(
        title: Text(title),
        description: Text(message),
        notificationPosition: NotificationPosition.bottomCenter,
        animation: AnimationType.fromBottom,
        background: Theme.of(context).scaffoldBackgroundColor,
      ).show(context);
    }
  }
}

///Toast Types
enum ToastType {
  success,
  info,
  error,
}
