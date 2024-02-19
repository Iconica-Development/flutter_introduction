// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

/// Widget representing a background with optional decoration.
class Background extends StatelessWidget {
  /// Constructs a Background widget.
  const Background({
    required this.child,
    this.background,
    super.key,
  });

  /// Optional decoration for the background.
  final BoxDecoration? background;

  /// The widget to be placed on the background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var background = this.background ??
        BoxDecoration(
          color: theme.colorScheme.background,
        );
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: background,
      child: child,
    );
  }
}
