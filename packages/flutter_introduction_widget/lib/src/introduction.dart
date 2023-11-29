// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/src/config/introduction.dart';
import 'package:flutter_introduction_widget/src/types/page_introduction.dart';
import 'package:flutter_introduction_widget/src/types/single_introduction.dart';

const kAnimationDuration = Duration(milliseconds: 300);

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({
    required this.options,
    required this.onComplete,
    super.key,
    this.physics,
    this.onNext,
    this.onPrevious,
    this.onSkip,
  });

  /// The options used to build the introduction screen
  final IntroductionOptions options;

  /// A function called when the introductionSceen changes
  final VoidCallback onComplete;

  /// A function called when the introductionScreen is skipped
  final VoidCallback? onSkip;
  final ScrollPhysics? physics;

  /// A function called when the introductionScreen moved to the next page
  /// where the page provided is the page where the user currently moved to
  final void Function(IntroductionPage)? onNext;

  /// A function called when the introductionScreen moved to the previous page
  /// where the page provided is the page where the user currently moved to
  final void Function(IntroductionPage)? onPrevious;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) {
            switch (options.displayMode) {
              case IntroductionDisplayMode.multiPageHorizontal:
                return MultiPageIntroductionScreen(
                  onComplete: onComplete,
                  physics: physics,
                  onSkip: onSkip,
                  onPrevious: onPrevious,
                  onNext: onNext,
                  options: options,
                );
              case IntroductionDisplayMode.singleScrollablePageVertical:
                return SingleIntroductionPage(
                  options: options,
                );
            }
          },
        ),
      );
}
