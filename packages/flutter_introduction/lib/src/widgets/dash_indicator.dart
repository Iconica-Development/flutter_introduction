import "package:flutter/material.dart";

class DashIndicator extends StatelessWidget {
  const DashIndicator({
    required this.controller,
    required this.indicatorColor,
    required this.indicatorSize,
    required this.indicatorSpacing,
    required this.pageCount,
    super.key,
  });
  final PageController controller;
  final Color indicatorColor;
  final double indicatorSize;
  final double indicatorSpacing;
  final int pageCount;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageCount,
            (index) => Container(
              width: indicatorSize * 2,
              height: indicatorSize / 2,
              margin: EdgeInsets.symmetric(horizontal: indicatorSpacing / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: index == (controller.page?.round() ?? 0)
                    ? indicatorColor
                    : indicatorColor.withOpacity(0.5),
              ),
              child: InkWell(
                onTap: () async => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        ),
      );
}
