import "package:flutter/material.dart";
import "package:flutter_introduction/flutter_introduction.dart";
import "package:flutter_introduction/src/config/introduction_theme.dart";
import "package:flutter_introduction/src/enums/introduction_layout_style.dart";

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({
    required this.title,
    required this.description,
    required this.graphic,
    required this.introductionTheme,
    required this.imageMode,
    this.layoutStyle = IntroductionLayoutStyle.imageBottom,
    super.key,
  });

  final String title;
  final String description;
  final String graphic;
  final IntroductionLayoutStyle layoutStyle;
  final IntroductionTheme introductionTheme;
  final ImageMode imageMode;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...switch (layoutStyle) {
            IntroductionLayoutStyle.imageTop => [
                const SizedBox(
                  height: 124,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: imageMode == ImageMode.asset
                      ? Image.asset(graphic)
                      : Image.network(graphic),
                ),
                const SizedBox(height: 40),
                Text(
                  title,
                  style: introductionTheme.titleTextStyle ??
                      theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: introductionTheme.descriptionTextStyle ??
                      theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            IntroductionLayoutStyle.imageCenter => [
                const SizedBox(
                  height: 124,
                ),
                Text(
                  title,
                  style: introductionTheme.titleTextStyle ??
                      theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: imageMode == ImageMode.asset
                      ? Image.asset(graphic)
                      : Image.network(graphic),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: introductionTheme.descriptionTextStyle ??
                      theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            IntroductionLayoutStyle.imageBottom => [
                const SizedBox(
                  height: 124,
                ),
                Text(
                  title,
                  style: introductionTheme.titleTextStyle ??
                      theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: introductionTheme.descriptionTextStyle ??
                      theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: imageMode == ImageMode.asset
                      ? Image.asset(graphic)
                      : Image.network(graphic),
                ),
              ],
          },
        ],
      ),
    );
  }
}
