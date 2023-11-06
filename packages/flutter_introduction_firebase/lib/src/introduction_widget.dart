// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: discarded_futures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_firebase/flutter_introduction_firebase.dart';
import 'package:flutter_introduction_service/flutter_introduction_service.dart';

export 'package:flutter_introduction_firebase/src/introduction_page.dart';
export 'package:flutter_introduction_widget/flutter_introduction_widget.dart';

class IntroductionFirebase extends StatefulWidget {
  const IntroductionFirebase({
    required this.options,
    required this.onComplete,
    this.decoration,
    this.layoutStyle,
    this.titleBuilder,
    this.contentBuilder,
    this.imageBuilder,
    this.onSkip,
    this.firebaseService,
    this.introductionService,
    this.physics,
    this.child,
    this.languageCodeOverride,
    super.key,
  });

  /// The options used to build the introduction screen
  final IntroductionOptions options;

  /// The service used to determine if the introduction screen should be shown
  final IntroductionService? introductionService;

  /// The service used to get the introduction pages
  final FirebaseIntroductionService? firebaseService;

  /// A function called when the introductionSceen changes
  final VoidCallback onComplete;

  /// A function called when the introductionScreen is skipped
  final VoidCallback? onSkip;

  /// How the single child scroll view should respond to scrolling
  final ScrollPhysics? physics;

  /// The widget to show when the introduction screen is loading
  final Widget? child;

  /// The decoration of an introduction page if it doesn't have
  ///  a backgroundImage or backgroundColor
  final BoxDecoration? decoration;

  /// The layout style of all the introduction pages
  final IntroductionLayoutStyle? layoutStyle;

  /// The builder used to build the title of the introduction page
  final Widget Function(String)? titleBuilder;

  /// The builder used to build the content of the introduction page
  final Widget Function(String)? contentBuilder;

  /// The builder used to build the image of the introduction page
  final Widget Function(String)? imageBuilder;

  /// Use this to override the language code that is in the context
  /// used for showing the introduction in a different language
  final String? languageCodeOverride;

  @override
  State<IntroductionFirebase> createState() => _IntroductionState();
}

class _IntroductionState extends State<IntroductionFirebase> {
  late IntroductionService _service;
  late FirebaseIntroductionService _firebaseService;

  @override
  void initState() {
    super.initState();
    if (widget.introductionService == null) {
      _service = IntroductionService();
    } else {
      _service = widget.introductionService!;
    }
    if (widget.firebaseService == null) {
      _firebaseService = FirebaseIntroductionService();
    } else {
      _firebaseService = widget.firebaseService!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> shouldShow() async =>
        await _service.shouldShow() ||
        await _firebaseService.shouldAlwaysShowIntroduction();
    var languageCode = widget.languageCodeOverride ??
        Localizations.localeOf(context).languageCode;
    return FutureBuilder(
      future: shouldShow(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
          return FutureBuilder(
            future: _firebaseService.getIntroductionPages(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data is List<IntroductionPageData>) {
                return IntroductionScreen(
                  options: widget.options.copyWith(
                    pages: snapshot.data?.map(
                      (e) {
                        var title = e.title.isEmpty
                            ? ''
                            : e.title.containsKey(languageCode)
                                ? e.title[languageCode]!
                                : e.title.values.first;
                        var content = e.content.isEmpty
                            ? ''
                            : e.content.containsKey(languageCode)
                                ? e.content[languageCode]!
                                : e.content.values.first;
                        return IntroductionPage(
                          title:
                              widget.titleBuilder?.call(title) ?? Text(title),
                          graphic: e.contentImage != null &&
                                  e.contentImage!.isNotEmpty
                              ? widget.imageBuilder?.call(e.contentImage!) ??
                                  CachedNetworkImage(imageUrl: e.contentImage!)
                              : null,
                          text: widget.contentBuilder?.call(content) ??
                              Text(content),
                          decoration: widget.decoration?.copyWith(
                            color: e.backgroundColor,
                            image: e.backgroundImage != null &&
                                    e.backgroundImage!.isNotEmpty
                                ? DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      e.backgroundImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          layoutStyle: widget.layoutStyle,
                        );
                      },
                    ).toList(),
                  ),
                  onComplete: () async {
                    await _service.onComplete();
                    widget.onComplete();
                  },
                  physics: widget.physics,
                  onSkip: () async {
                    await _service.onSkip();
                    widget.onComplete();
                  },
                );
              } else {
                return widget.child ?? const CircularProgressIndicator();
              }
            },
          );
        } else {
          if (snapshot.hasData && snapshot.data != null && !snapshot.data!) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await _service.onComplete();
              widget.onComplete();
            });
          }
          return widget.child ?? const CircularProgressIndicator();
        }
      },
    );
  }
}
