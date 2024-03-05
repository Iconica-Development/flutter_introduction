// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'package:flutter_introduction_widget/src/config/introduction.dart';

/// Widget representing the content of an introduction page.
class IntroductionPageContent extends StatelessWidget {
  /// Constructs an IntroductionPageContent widget.
  const IntroductionPageContent({
    required this.title,
    required this.text,
    required this.graphic,
    required this.layoutStyle,
    required this.onTap,
    super.key,
  });

  /// The title widget.
  final Widget? title;

  /// The text widget.
  final Widget? text;

  /// The graphic widget.
  final Widget? graphic;

  /// The layout style of the content.
  final IntroductionLayoutStyle layoutStyle;

  /// Callback function called when the content is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            if (graphic != null &&
                layoutStyle == IntroductionLayoutStyle.imageTop)
              graphic!,
            if (title != null) title!,
            if (graphic != null &&
                layoutStyle == IntroductionLayoutStyle.imageCenter)
              graphic!,
            if (text != null) text!,
            if (graphic != null &&
                layoutStyle == IntroductionLayoutStyle.imageBottom)
              graphic!,
          ],
        ),
      );
}
