// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

class IntroductionTheme {
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final TextStyle? buttonTextStyle;
  final Color? backgroundColor;
  final Color indicatorColor;
  final Color? buttonBackgroundColor;
  final Color buttonBorderColor;
  final double indicatorSize;
  final double indicatorSpacing;

  const IntroductionTheme({
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.buttonTextStyle,
    this.backgroundColor,
    this.indicatorColor = Colors.black,
    this.buttonBackgroundColor = Colors.transparent,
    this.buttonBorderColor = const Color(0xfb979797),
    this.indicatorSize = 12,
    this.indicatorSpacing = 12,
  });
}
