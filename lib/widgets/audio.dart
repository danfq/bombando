import 'package:flutter/material.dart';

///Pretty Buttons
class PrettyButtons {
  ///Audio Button
  static Widget audio({
    required BuildContext context,
    required String name,
    required String url,
  }) {
    return Card(
      elevation: 4.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
