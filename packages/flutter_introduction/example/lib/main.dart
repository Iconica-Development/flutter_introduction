// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_introduction/flutter_introduction.dart';
import 'package:flutter_introduction_shared_preferences/flutter_introduction_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IntroductionService service =
      IntroductionService(SharedPreferencesIntroductionDataProvider());

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Introduction(
          options: IntroductionOptions(
            pages: [
              IntroductionPage(
                title: const Text('First page'),
                text: const Text('Wow a page'),
                graphic: const FlutterLogo(),
              ),
              IntroductionPage(
                title: const Text('Second page'),
                text: const Text('Another page'),
                graphic: const FlutterLogo(),
              ),
              IntroductionPage(
                title: const Text('Third page'),
                text: const Text('The final page of this app'),
                graphic: const FlutterLogo(),
              ),
            ],
            introductionTranslations: const IntroductionTranslations(
              skipButton: 'Skip it!',
              nextButton: 'Next',
              previousButton: 'Previous',
              finishButton: 'To the app!',
            ),
            tapEnabled: true,
            displayMode: IntroductionDisplayMode.multiPageHorizontal,
            buttonMode: IntroductionScreenButtonMode.text,
            indicatorMode: IndicatorMode.dash,
            skippable: true,
            buttonBuilder: (context, onPressed, child, type) =>
                ElevatedButton(onPressed: onPressed, child: child),
          ),
          service: service,
          navigateTo: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
          child: const Home(),
        ),
      );
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container();
}
