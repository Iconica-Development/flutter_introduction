// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

library flutter_introduction;

import 'package:flutter/material.dart';
import 'package:flutter_introduction_service/flutter_introduction_service.dart';
import 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

export 'package:flutter_introduction_widget/flutter_introduction_widget.dart';
export 'package:flutter_introduction_service/flutter_introduction_service.dart';

class Introduction extends StatefulWidget {
  const Introduction({
    required this.navigateTo,
    required this.options,
    this.child,
    this.physics,
    this.service,
    super.key,
  });

  final Function navigateTo;
  final IntroductionService? service;
  final IntroductionOptions options;
  final ScrollPhysics? physics;
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _service.shouldShow(),
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data!) {
          return IntroductionScreen(
            options: widget.options,
            onComplete: () async {
              _service.onComplete();
              widget.navigateTo();
            },
            physics: widget.physics,
            onSkip: () async {
              _service.onComplete();
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
}
