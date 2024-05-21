// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_introduction_service/flutter_introduction_service.dart';
import 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

export 'package:flutter_introduction_service/flutter_introduction_service.dart';
export 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

class Introduction extends StatefulWidget {
  const Introduction({
    required this.navigateTo,
    required this.options,
    this.child,
    this.physics,
    this.service,
    super.key,
  });

  /// Callback function to navigate to the next screen.
  final VoidCallback navigateTo;

  /// The introduction service to use.
  final IntroductionService? service;

  /// Options for configuring the introduction screen.
  final IntroductionOptions options;

  /// The scrolling physics for the introduction screen.
  final ScrollPhysics? physics;

  /// Child widget to display.
  final Widget? child;

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  late IntroductionService _service;

  @override
  void initState() {
    super.initState();
    if (widget.service == null) {
      _service = IntroductionService();
    } else {
      _service = widget.service!;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        // ignore: discarded_futures
        future: _service.shouldShow(),
        builder: (context, snapshot) {
          if (snapshot.data == null ||
              snapshot.data! ||
              widget.options.mode == IntroductionScreenMode.showAlways) {
            return IntroductionScreen(
              options: widget.options,
              onComplete: () async {
                await _service.onComplete();
                widget.navigateTo();
              },
              physics: widget.physics,
              onSkip: () async {
                await _service.onComplete();
                widget.navigateTo();
              },
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.navigateTo();
            });
            return widget.child ?? const CircularProgressIndicator();
          }
        },
      );
}
