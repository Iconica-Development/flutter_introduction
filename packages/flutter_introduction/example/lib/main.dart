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
            pages: (context) => [
              const IntroductionPage(
                title: Text('First page'),
                text: Text('Wow a page'),
                graphic: FlutterLogo(),
              ),
              const IntroductionPage(
                title: Text('Second page'),
                text: Text('Another page'),
                graphic: FlutterLogo(),
              ),
              const IntroductionPage(
                title: Text('Third page'),
                text: Text('The final page of this app'),
                graphic: FlutterLogo(),
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
