import 'package:toast/toast.dart';

///Toasts
class Toasts {
  ///Show with Custom Message
  static void show({
    required String message,
  }) {
    Toast.show(message);
  }
}
