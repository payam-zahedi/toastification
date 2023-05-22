import 'package:example/src/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ToastificationApp());
}

class ToastificationApp extends StatelessWidget {
  const ToastificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: Container(),
    );
  }
}
