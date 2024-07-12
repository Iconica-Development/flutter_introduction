// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IntroductionScreen(
        options: IntroductionOptions(
          pages: (context) => [
            const IntroductionPage(
              title: Text('Basic Page'),
              text: Text(
                'A page with some text and a widget in the middle.',
              ),
              graphic: FlutterLogo(size: 100),
            ),
            const IntroductionPage(
              title: Text('Layout Shift'),
              text: Text(
                'You can change the layout of a page to mix things up.',
              ),
              graphic: FlutterLogo(size: 100),
              layoutStyle: IntroductionLayoutStyle.imageTop,
            ),
            const IntroductionPage(
              title: Text(
                'Decoration',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.yellow,
                    Colors.red,
                    Colors.indigo,
                    Colors.teal,
                  ],
                ),
              ),
              text: Text(
                'Add a Decoration to make a custom background, like a LinearGradient',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              graphic: FlutterLogo(
                size: 100,
              ),
            ),
            const IntroductionPage(
              title: Text(
                'Background Image',
              ),
              text: Text(
                'Add a Decoration with a DecorationImage, to add an background image',
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/flutter_introduction_background.jpeg',
                  ),
                ),
              ),
            ),
          ],
          introductionTranslations: const IntroductionTranslations(
            skipButton: 'Skip it!',
            nextButton: 'Next',
            previousButton: 'Previous',
            finishButton: 'Finish',
          ),
          tapEnabled: true,
          displayMode: IntroductionDisplayMode.multiPageHorizontal,
          buttonMode: IntroductionScreenButtonMode.text,
          indicatorMode: IndicatorMode.dash,
          skippable: true,
          buttonBuilder: (context, onPressed, child, buttonType) =>
              ElevatedButton(onPressed: onPressed, child: child),
        ),
        onComplete: () {
          debugPrint('We completed the cycle');
        },
      ),
    );
  }
}
