import "package:flutter/material.dart";
import "package:flutter_introduction/flutter_introduction.dart";

class IntroductionOptions {
  const IntroductionOptions({
    this.indicatorMode = IndicatorMode.dot,
    this.layoutStyle = IntroductionLayoutStyle.imageBottom,
    this.introductionScreenMode = IntroductionScreenMode.showOnce,
    this.indicatorBuilder,
    this.introductionPages = const [
      IntroductionPageData(
        id: 1,
        title: "welcome to iconinstagram",
        description: "Welcome to the world of iconinstagram, where creativity"
            " knows no bounds and connections are made through"
            " captivating visuals.",
        graphic: "packages/flutter_introduction/assets/first.png",
      ),
      IntroductionPageData(
        id: 2,
        title: "discover iconinstagram",
        description: "Dive into the vibrant world of iconinstagram and"
            " discover endless possibilities. From stunning"
            " photography to engaging videos, iconinstagram"
            " offers a diverse range of content to explore.",
        graphic: "packages/flutter_introduction/assets/second.png",
      ),
      IntroductionPageData(
        id: 3,
        title: "elevate your experience",
        description: "Whether promoting your business, or connecting"
            " with friends and family, iconinstagram provides"
            " the tools and platform to make your voice heard.",
        graphic: "packages/flutter_introduction/assets/third.png",
      ),
    ],
  });

  final IndicatorMode indicatorMode;

  final IntroductionLayoutStyle layoutStyle;
  final IntroductionScreenMode introductionScreenMode;
  final Function(
    BuildContext context,
    PageController controller,
    int currentPage,
    int totalPages,
  )? indicatorBuilder;
  final List<IntroductionPageData> introductionPages;
}
