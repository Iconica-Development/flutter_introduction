// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_introduction_widget/src/config/introduction.dart';
import 'package:flutter_introduction_widget/src/introduction.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    required this.mode,
    required this.controller,
    required this.count,
    required this.index,
    required this.indicatorBuilder,
    required this.dotSize,
    required this.dotSpacing,
    required this.options,
    super.key,
  }) : assert(
          !(mode == IndicatorMode.custom && indicatorBuilder == null),
          'When a custom indicator is used the indicatorBuilder '
          'must be provided',
        );

  /// The mode of the indicator.
  final IndicatorMode mode;

  /// The PageController for which the indicator is displayed.
  final PageController controller;

  /// The total number of items managed by the PageController.
  final int count;

  /// The index of the current item in the PageController.
  final int index;

  /// Builder function for a custom indicator.
  final Widget Function(BuildContext, PageController, int, int)?
      indicatorBuilder;

  /// The size of the dots.
  final double dotSize;

  /// The distance between the center of each dot.
  final double dotSpacing;

  final IntroductionOptions options;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    switch (mode) {
      case IndicatorMode.custom:
        return indicatorBuilder!.call(context, controller, index, count);
      case IndicatorMode.dot:
        return DotsIndicator(
          dotSize: dotSize,
          dotSpacing: dotSpacing,
          controller: controller,
          color: options.dotColor ?? theme.colorScheme.primary,
          itemCount: count,
          onPageSelected: (int page) {
            unawaited(
              controller.animateToPage(
                page,
                duration: kAnimationDuration,
                curve: Curves.easeInOut,
              ),
            );
          },
        );
      case IndicatorMode.dash:
        return DashIndicator(
          color: theme.colorScheme.primary,
          controller: controller,
          selectedColor: options.dotColor ?? theme.colorScheme.primary,
          itemCount: count,
          onPageSelected: (int page) {
            unawaited(
              controller.animateToPage(
                page,
                duration: kAnimationDuration,
                curve: Curves.easeInOut,
              ),
            );
          },
        );
    }
  }
}

class DashIndicator extends AnimatedWidget {
  const DashIndicator({
    required this.controller,
    required this.selectedColor,
    required this.itemCount,
    required this.onPageSelected,
    this.color = Colors.white,
    super.key,
  }) : super(listenable: controller);

  /// The PageController for which the indicator is displayed.
  final PageController controller;

  /// The color of the dashes.
  final Color color;

  /// The color of the selected dash.
  final Color selectedColor;

  /// The total number of items managed by the PageController.
  final int itemCount;

  /// Callback function called when a dash is selected.
  final Function(int) onPageSelected;

  int _getPage() {
    try {
      return controller.page?.round() ?? 0;
    } on Exception catch (_) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = _getPage();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < itemCount; i++) ...[
          buildDash(i, selected: index == i),
        ],
      ],
    );
  }

  Widget buildDash(int index, {required bool selected}) => SizedBox(
        width: 20,
        child: Center(
          child: Material(
            color: selected ? color : color.withAlpha(125),
            type: MaterialType.card,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
              ),
              width: 16,
              height: 5,
              child: InkWell(
                onTap: () => onPageSelected.call(index),
              ),
            ),
          ),
        ),
      );
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    required this.controller,
    this.color = Colors.white,
    this.itemCount,
    this.onPageSelected,
    this.dotSize = 8.0,
    this.dotSpacing = 24.0,
    super.key,
  }) : super(
          listenable: controller,
        );

  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  final double dotSize;
  final double dotSpacing;

  Widget _buildDot(int index) => SizedBox(
        width: dotSpacing,
        child: Center(
          child: Material(
            color:
                (((controller.page ?? controller.initialPage).round()) == index
                    ? color
                    : color.withAlpha(125)),
            type: MaterialType.circle,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              width: dotSize,
              height: dotSize,
              child: InkWell(
                onTap: () => onPageSelected!.call(index),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount!, _buildDot),
      );
}
