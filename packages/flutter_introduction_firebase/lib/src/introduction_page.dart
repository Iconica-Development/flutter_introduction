// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

@immutable
class IntroductionPageData {
  const IntroductionPageData({
    required this.title,
    required this.content,
    this.contentImage,
    this.backgroundImage,
    this.backgroundColor,
  });

  /// The title of the introduction page in different languages
  final Map<String, String> title;

  /// The content of the introduction page in different languages
  final Map<String, String> content;

  /// The imageUrl of the graphic on the introduction page
  final String? contentImage;

  /// The imageUrl of the background image of the introduction page
  final String? backgroundImage;

  /// Optional background color of the introduction page
  ///  (defaults to transparent)
  final Color? backgroundColor;
}
