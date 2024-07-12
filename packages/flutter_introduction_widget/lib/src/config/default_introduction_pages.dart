import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

List<IntroductionPage> defaultIntroductionPages(BuildContext context) {
  var theme = Theme.of(context);
  return [
    IntroductionPage(
      title: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'welcome to iconinstagram',
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 6),
        ],
      ),
      graphic: const Image(
        image: AssetImage(
          'assets/first.png',
          package: 'flutter_introduction_widget',
        ),
      ),
      text: Text(
        'Welcome to the world of Instagram, where creativity'
        ' knows no bounds and connections are made'
        ' through captivating visuals.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
    ),
    IntroductionPage(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            'discover iconinstagram',
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 6),
        ],
      ),
      text: Text(
        'Dive into the vibrant world of'
        ' Instagram and discover endless possibilities.'
        ' From stunning photography to engaging videos,'
        ' Instagram offers a diverse range of content to explore and enjoy.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
      graphic: const Image(
        image: AssetImage(
          'assets/second.png',
          package: 'flutter_introduction_widget',
        ),
      ),
    ),
    IntroductionPage(
      title: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'elevate your experience',
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 6),
        ],
      ),
      graphic: const Image(
        image: AssetImage(
          'assets/third.png',
          package: 'flutter_introduction_widget',
        ),
      ),
      text: Text(
        'Whether promoting your business, or connecting'
        ' with friends and family, Instagram provides the'
        ' tools and platform to make your voice heard.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
    ),
  ];
}
