import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

const List<IntroductionPage> defaultIntroductionPages = [
  IntroductionPage(
    decoration: BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: Column(
      children: [
        SizedBox(height: 100),
        Text(
          'welcome to iconinstagram',
          style: TextStyle(
            color: Color(0xff71C6D1),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Welcome to the world of Instagram, where creativity'
          ' knows no bounds and connections are made'
          ' through captivating visuals.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    graphic: Image(
      image: AssetImage(
        'assets/first.png',
        package: 'flutter_introduction_widget',
      ),
    ),
    text: Text(''),
  ),
  IntroductionPage(
    decoration: BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Text(
          'discover iconinstagram',
          style: TextStyle(
            color: Color(0xff71C6D1),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Dive into the vibrant world of'
          ' Instagram and discover endless possibilities.'
          ' From stunning photography to engaging videos,'
          ' Instagram offers a diverse range of content to explore and enjoy.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    graphic: Image(
      image: AssetImage(
        'assets/second.png',
        package: 'flutter_introduction_widget',
      ),
    ),
    text: Text(''),
  ),
  IntroductionPage(
    decoration: BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: Column(
      children: [
        SizedBox(height: 100),
        Text(
          'elevate your experience',
          style: TextStyle(
            color: Color(0xff71C6D1),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Whether promoting your business, or connecting'
          ' with friends and family, Instagram provides the'
          ' tools and platform to make your voice heard.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    graphic: Image(
      image: AssetImage(
        'assets/third.png',
        package: 'flutter_introduction_widget',
      ),
    ),
    text: Text(''),
  ),
];
