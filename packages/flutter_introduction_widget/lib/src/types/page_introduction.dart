// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/src/config/introduction.dart';
import 'package:flutter_introduction_widget/src/introduction.dart';
import 'package:flutter_introduction_widget/src/widgets/background.dart';
import 'package:flutter_introduction_widget/src/widgets/indicator.dart';
import 'package:flutter_introduction_widget/src/widgets/page_content.dart';

/// A screen widget for displaying a multi-page introduction.
///
/// This widget provides a multi-page introduction experience with options
/// for handling navigation and completion callbacks.
class MultiPageIntroductionScreen extends StatefulWidget {
  /// Creates a new instance of [MultiPageIntroductionScreen].
  const MultiPageIntroductionScreen({
    required this.options,
    required this.onComplete,
    this.physics,
    this.onNext,
    this.onPrevious,
    this.onSkip,
    super.key,
  });

  /// Callback function triggered when the introduction is completed.
  final VoidCallback onComplete;

  /// Callback function triggered when the "Next" button is pressed.
  final void Function(IntroductionPage)? onNext;

  /// Callback function triggered when the "Previous" button is pressed.
  final void Function(IntroductionPage)? onPrevious;

  /// Callback function triggered when the "Skip" button is pressed.
  final VoidCallback? onSkip;

  /// Physics for the scrolling behavior.
  final ScrollPhysics? physics;

  /// Introduction options specifying the configuration of the introduction.
  final IntroductionOptions options;

  @override
  State<MultiPageIntroductionScreen> createState() =>
      _MultiPageIntroductionScreenState();
}

/// State class for [MultiPageIntroductionScreen].
///
/// Manages the state and behavior of the [MultiPageIntroductionScreen] widget.
class _MultiPageIntroductionScreenState
    extends State<MultiPageIntroductionScreen> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);
  }

  void _handleScroll() {
    _currentPage.value = _controller.page?.round() ?? 0;
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pages = widget.options.pages.call(context);
    var translations = widget.options.introductionTranslations;
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is OverscrollNotification) {
              if (notification.overscroll > 8) {
                widget.onComplete.call();
              }
            }
            // add bouncing scroll physics support
            if (notification is ScrollUpdateNotification) {
              var offset = notification.metrics.pixels;
              if (offset > notification.metrics.maxScrollExtent + 8) {
                widget.onComplete.call();
              }
            }
            return false;
          },
          child: PageView(
            controller: _controller,
            physics: widget.physics,
            children: List.generate(
              pages.length,
              (index) => ExplainerPage(
                onTap: () {
                  widget.onNext?.call(pages[_currentPage.value]);
                },
                controller: _controller,
                page: pages[index],
                options: widget.options,
                index: index,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.options.controlMode ==
                  IntroductionControlMode.previousNextButton) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    height: 64,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.options.skippable && !_isLast(pages)) ...[
                            TextButton(
                              onPressed: widget.onComplete,
                              child: Text(translations.skipButton),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox.shrink(),
              ],
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _currentPage,
                      builder: (context, _) => Indicator(
                        options: widget.options,
                        indicatorBuilder: widget.options.indicatorBuilder,
                        mode: widget.options.indicatorMode,
                        controller: _controller,
                        count: pages.length,
                        index: _currentPage.value,
                        dotSize: widget.options.dotSize,
                        dotSpacing: widget.options.dotSpacing,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          if (widget.options.controlMode ==
                              IntroductionControlMode.singleButton) {
                            return IntroductionOneButton(
                              controller: _controller,
                              next: _isNext(pages),
                              previous: _isPrevious,
                              last: _isLast(pages),
                              options: widget.options,
                              onFinish: widget.onComplete,
                              onNext: () {
                                widget.onNext?.call(pages[_currentPage.value]);
                              },
                              onPrevious: () {
                                widget.onNext?.call(pages[_currentPage.value]);
                              },
                            );
                          }

                          return IntroductionTwoButtons(
                            controller: _controller,
                            next: _isNext(pages),
                            previous: _isPrevious,
                            last: _isLast(pages),
                            options: widget.options,
                            onFinish: widget.onComplete,
                            onNext: () {
                              widget.onNext?.call(pages[_currentPage.value]);
                            },
                            onPrevious: () {
                              widget.onNext?.call(pages[_currentPage.value]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => IntroductionIconButtons(
            controller: _controller,
            next: _isNext(pages),
            previous: _isPrevious,
            last: _isLast(pages),
            options: widget.options,
            onFinish: widget.onComplete,
            onNext: () {
              widget.onNext?.call(pages[_currentPage.value]);
            },
            onPrevious: () {
              widget.onNext?.call(pages[_currentPage.value]);
            },
          ),
        ),
      ],
    );
  }

  bool _isLast(List<IntroductionPage> pages) =>
      _currentPage.value == pages.length - 1;

  bool get _isPrevious => _currentPage.value > 0;

  bool _isNext(List<IntroductionPage> pages) =>
      _currentPage.value < pages.length - 1;
}

class ExplainerPage extends StatelessWidget {
  const ExplainerPage({
    required this.page,
    required this.options,
    required this.index,
    required this.controller,
    this.onTap,
    super.key,
  });

  final IntroductionPage page;
  final IntroductionOptions options;
  final PageController controller;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Background(
      background: page.decoration,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Expanded(
              child: IntroductionPageContent(
                onTap: () {
                  if (options.tapEnabled) {
                    onTap?.call();
                  }
                },
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: DefaultTextStyle(
                    style: theme.textTheme.titleMedium!,
                    child: page.title ?? Text('introduction.$index.title'),
                  ),
                ),
                text: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium!,
                    child: page.text ?? Text('introduction.$index.description'),
                  ),
                ),
                graphic: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: page.graphic,
                  ),
                ),
                layoutStyle: page.layoutStyle ?? options.layoutStyle,
              ),
            ),
            const SizedBox(
              height: 144,
            ),
          ],
        ),
      ),
    );
  }
}

class IntroductionTwoButtons extends StatelessWidget {
  const IntroductionTwoButtons({
    required this.options,
    required this.controller,
    required this.next,
    required this.last,
    required this.previous,
    required this.onFinish,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  final IntroductionOptions options;
  final PageController controller;
  final VoidCallback? onFinish;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  final bool previous;
  final bool next;
  final bool last;

  Future<void> _previous() async {
    await controller.previousPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onPrevious?.call();
  }

  @override
  Widget build(BuildContext context) {
    var translations = options.introductionTranslations;
    var showFinishButton =
        options.buttonMode == IntroductionScreenButtonMode.singleFinish;
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (options.buttonMode == IntroductionScreenButtonMode.text) ...[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 180,
                ),
                child: Opacity(
                  opacity: previous ? 1 : 0,
                  child: IgnorePointer(
                    ignoring: !previous,
                    child: options.buttonBuilder?.call(
                          context,
                          _previous,
                          Text(
                            translations.previousButton,
                            style: options.introductionButtonTextstyles
                                    .previousButtonStyle ??
                                theme.textTheme.bodyMedium,
                          ),
                          IntroductionButtonType.previous,
                        ) ??
                        InkWell(
                          onTap: _previous,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0xff979797,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  translations.previousButton,
                                  style: options.introductionButtonTextstyles
                                          .previousButtonStyle ??
                                      theme.textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),
          if (next) ...[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 180,
                  ),
                  child: options.buttonBuilder?.call(
                        context,
                        _next,
                        Text(
                          translations.nextButton,
                          style: options.introductionButtonTextstyles
                                  .nextButtonStyle ??
                              theme.textTheme.bodyMedium,
                        ),
                        IntroductionButtonType.next,
                      ) ??
                      InkWell(
                        onTap: _next,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(
                                0xff979797,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                translations.nextButton,
                                style: options.introductionButtonTextstyles
                                        .nextButtonStyle ??
                                    theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ] else if (last) ...[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 180,
                  ),
                  child: options.buttonBuilder?.call(
                        context,
                        () {
                          onFinish?.call();
                        },
                        Text(
                          translations.finishButton,
                          style: options.introductionButtonTextstyles
                                  .finishButtonStyle ??
                              theme.textTheme.bodyMedium,
                        ),
                        IntroductionButtonType.finish,
                      ) ??
                      InkWell(
                        onTap: () {
                          onFinish?.call();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(
                                0xff979797,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                translations.finishButton,
                                style: options.introductionButtonTextstyles
                                        .finishButtonStyle ??
                                    theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ] else ...[
            const SizedBox.shrink(),
          ],
        ] else if (showFinishButton) ...[
          const SizedBox.shrink(),
          Expanded(
            child: Visibility(
              visible: last,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              maintainInteractivity: false,
              child: Align(
                child: Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 180,
                    ),
                    child: options.buttonBuilder?.call(
                          context,
                          () {
                            onFinish?.call();
                          },
                          Text(
                            translations.finishButton,
                            style: options.introductionButtonTextstyles
                                    .finishButtonStyle ??
                                theme.textTheme.bodyMedium,
                          ),
                          IntroductionButtonType.finish,
                        ) ??
                        InkWell(
                          onTap: () {
                            onFinish?.call();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0xff979797,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  translations.finishButton,
                                  style: options.introductionButtonTextstyles
                                          .finishButtonStyle ??
                                      theme.textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox.shrink(),
        ],
      ],
    );
  }

  Future<void> _next() async {
    await controller.nextPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onNext?.call();
  }
}

class IntroductionOneButton extends StatelessWidget {
  const IntroductionOneButton({
    required this.options,
    required this.controller,
    required this.next,
    required this.last,
    required this.previous,
    required this.onFinish,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  /// Options specifying the configuration of the introduction.
  final IntroductionOptions options;

  /// Controller for managing the pages of the introduction.
  final PageController controller;

  /// Callback function triggered when the introduction is completed.
  final VoidCallback? onFinish;

  /// Callback function triggered when the "Next" button is pressed.
  final VoidCallback? onNext;

  /// Callback function triggered when the "Previous" button is pressed.
  final VoidCallback? onPrevious;

  /// Indicates whether there are previous pages.
  final bool previous;

  /// Indicates whether there are next pages.
  final bool next;

  /// Indicates whether this is the last page.
  final bool last;

  /// Handles the navigation to the previous page.
  Future<void> _previous() async {
    await controller.previousPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onPrevious?.call();
  }

  @override
  Widget build(BuildContext context) {
    var translations = options.introductionTranslations;

    return Column(
      children: [
        if (options.buttonMode == IntroductionScreenButtonMode.text) ...[
          if (last) ...[
            options.buttonBuilder?.call(
                  context,
                  () {
                    onFinish?.call();
                  },
                  Text(
                    translations.finishButton,
                    style:
                        options.introductionButtonTextstyles.finishButtonStyle,
                  ),
                  IntroductionButtonType.finish,
                ) ??
                TextButton(
                  onPressed: () {
                    onFinish?.call();
                  },
                  child: Text(
                    translations.finishButton,
                    style:
                        options.introductionButtonTextstyles.finishButtonStyle,
                  ),
                ),
          ] else ...[
            options.buttonBuilder?.call(
                  context,
                  _next,
                  Text(
                    translations.nextButton,
                    style: options.introductionButtonTextstyles.nextButtonStyle,
                  ),
                  IntroductionButtonType.next,
                ) ??
                TextButton(
                  onPressed: _next,
                  child: Text(
                    translations.nextButton,
                    style: options.introductionButtonTextstyles.nextButtonStyle,
                  ),
                ),
          ],
          if (previous) ...[
            options.buttonBuilder?.call(
                  context,
                  _previous,
                  Text(
                    translations.previousButton,
                    style: options
                        .introductionButtonTextstyles.previousButtonStyle,
                  ),
                  IntroductionButtonType.previous,
                ) ??
                TextButton(
                  onPressed: _previous,
                  child: Text(
                    translations.previousButton,
                    style: options
                        .introductionButtonTextstyles.previousButtonStyle,
                  ),
                ),
          ] else ...[
            options.buttonBuilder?.call(
                  context,
                  () {
                    onFinish?.call();
                  },
                  Text(
                    translations.finishButton,
                    style:
                        options.introductionButtonTextstyles.finishButtonStyle,
                  ),
                  IntroductionButtonType.skip,
                ) ??
                TextButton(
                  onPressed: () {
                    onFinish?.call();
                  },
                  child: Text(
                    translations.finishButton,
                    style:
                        options.introductionButtonTextstyles.finishButtonStyle,
                  ),
                ),
          ],
        ],
      ],
    );
  }

  Future<void> _next() async {
    await controller.nextPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onNext?.call();
  }
}

class IntroductionIconButtons extends StatelessWidget {
  const IntroductionIconButtons({
    required this.options,
    required this.controller,
    required this.next,
    required this.last,
    required this.previous,
    required this.onFinish,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  /// Options specifying the configuration of the introduction.
  final IntroductionOptions options;

  /// Controller for managing the pages of the introduction.
  final PageController controller;

  /// Callback function triggered when the introduction is completed.
  final VoidCallback? onFinish;

  /// Callback function triggered when the "Next" button is pressed.
  final VoidCallback? onNext;

  /// Callback function triggered when the "Previous" button is pressed.
  final VoidCallback? onPrevious;

  /// Indicates whether there are previous pages.
  final bool previous;

  /// Indicates whether there are next pages.
  final bool next;

  /// Indicates whether this is the last page.
  final bool last;

  /// Handles the navigation to the previous page.
  Future<void> _previous() async {
    await controller.previousPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onPrevious?.call();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (options.buttonMode == IntroductionScreenButtonMode.icon) ...[
              if (previous) ...[
                IconButton(
                  iconSize: 70,
                  onPressed: _previous,
                  icon: const Icon(Icons.chevron_left),
                ),
              ] else
                const SizedBox.shrink(),
              IconButton(
                iconSize: 70,
                onPressed: () {
                  if (next) {
                    unawaited(_next());
                  } else {
                    onFinish?.call();
                  }
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ],
        ),
      );

  Future<void> _next() async {
    await controller.nextPage(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
    onNext?.call();
  }
}
