import 'package:bombando/pages/home.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(content: Text("Pressiona Outra Vez Para Sair")),
          child: Home(),
        ),
      ),
    ),
  );
}
