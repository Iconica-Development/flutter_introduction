import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction/flutter_introduction.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Introduction(),
    );
  }
}

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      onDone: () {
        debugPrint("done");
      },
    );
  }
}
