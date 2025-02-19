import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_introduction/src/config/introduction_options.dart";
import "package:flutter_introduction/src/config/introduction_theme.dart";
import "package:flutter_introduction/src/config/introduction_translations.dart";
import "package:flutter_introduction/src/enums/indicator_mode.dart";
import "package:flutter_introduction/src/enums/introduction_screen_mode.dart";
import "package:flutter_introduction/src/widgets/button.dart";
import "package:flutter_introduction/src/widgets/dash_indicator.dart";
import "package:flutter_introduction/src/widgets/dot_indicator.dart";
import "package:flutter_introduction/src/widgets/introduction_page.dart";
import "package:introduction_repository_interface/introduction_repository_interface.dart";

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({
    required this.onDone,
    this.introductionService,
    this.options = const IntroductionOptions(),
    this.translations = const IntroductionTranslations(),
    this.introductionTheme = const IntroductionTheme(),
    super.key,
  });

  final IntroductionService? introductionService;
  final IntroductionOptions options;
  final IntroductionTranslations translations;
  final IntroductionTheme introductionTheme;
  final Function(BuildContext context) onDone;

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  IntroductionService? introductionService;
  bool? shouldShow;
  @override
  void initState() {
    introductionService = widget.introductionService ?? IntroductionService();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkShouldShow();
    });
  }

  Future<void> checkShouldShow() async {
    shouldShow = await introductionService?.shouldShow();
    if (widget.options.introductionScreenMode ==
        IntroductionScreenMode.showAlways) {
      shouldShow = true;
    }
    if (widget.options.introductionScreenMode ==
        IntroductionScreenMode.showNever) {
      shouldShow = false;
    }
    if (!shouldShow! && mounted) {
      await widget.onDone.call(context);
    }
  }

  Future<List<IntroductionPageData>> fetchIntroductionPages() async {
    try {
      var pages = await introductionService!.fetchIntroductionPages();
      if (pages.isEmpty) {
        return widget.options.introductionPages;
      }
      return pages;
    } on Exception catch (_) {
      return widget.options.introductionPages;
    }
  }

  @override
  Widget build(BuildContext context) {
    var pages = <IntroductionPage>[];

    return Scaffold(
      body: FutureBuilder(
        // ignore: discarded_futures
        future: fetchIntroductionPages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (shouldShow != null && !shouldShow!) {
            return const SizedBox.shrink();
          }
          for (var page in snapshot.data!) {
            pages.add(
              IntroductionPage(
                title: page.title,
                description: page.description,
                graphic: page.graphic,
                imageMode: page.imageMode,
                introductionTheme: widget.introductionTheme,
              ),
            );
          }

          return _IntroductionScreen(
            pages: pages,
            options: widget.options,
            translations: widget.translations,
            introductionTheme: widget.introductionTheme,
            onDone: (context) async {
              await introductionService?.setCompleted();
              if (mounted) {
                // ignore: use_build_context_synchronously
                await widget.onDone.call(context);
              }
            },
          );
        },
      ),
    );
  }
}

class _IntroductionScreen extends StatefulWidget {
  const _IntroductionScreen({
    required this.pages,
    required this.onDone,
    required this.options,
    required this.translations,
    required this.introductionTheme,
  });

  final IntroductionOptions options;
  final IntroductionTranslations translations;
  final List<IntroductionPage> pages;
  final Function(BuildContext context) onDone;
  final IntroductionTheme introductionTheme;

  @override
  State<_IntroductionScreen> createState() => __IntroductionScreenState();
}

class __IntroductionScreenState extends State<_IntroductionScreen> {
  PageController controller = PageController();
  bool isAnimating = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      var newPage = controller.page?.round() ?? 0;
      if (newPage != currentPage) {
        setState(() {
          currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var options = widget.options;
    var introductionTheme = widget.introductionTheme;
    var showNextButton = currentPage < widget.pages.length - 1;
    var showPreviousButton = currentPage > 0;
    var isLastPage = currentPage == widget.pages.length - 1;

    return Scaffold(
      backgroundColor: widget.introductionTheme.backgroundColor ??
          Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                children: [
                  ...widget.pages,
                ],
              ),
            ),
            Column(
              children: [
                ...switch (options.indicatorMode) {
                  IndicatorMode.dot => [
                      DotsIndicator(
                        controller: controller,
                        pageCount: widget.pages.length,
                        indicatorSize: introductionTheme.indicatorSize,
                        indicatorSpacing: introductionTheme.indicatorSpacing,
                        indicatorColor: introductionTheme.indicatorColor,
                      ),
                    ],
                  IndicatorMode.dash => [
                      DashIndicator(
                        controller: controller,
                        pageCount: widget.pages.length,
                        indicatorSize: introductionTheme.indicatorSize,
                        indicatorSpacing: introductionTheme.indicatorSpacing,
                        indicatorColor: introductionTheme.indicatorColor,
                      ),
                    ],
                  IndicatorMode.custom => [
                      widget.options.indicatorBuilder?.call(
                        context,
                        controller,
                        currentPage,
                        widget.pages.length,
                      ),
                    ],
                },
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        showButton: showPreviousButton,
                        text: widget.translations.previousButton,
                        introductionTheme: widget.introductionTheme,
                        onPressed: () async {
                          if (isAnimating) return;
                          isAnimating = true;
                          setState(() {});
                          await controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          isAnimating = false;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      if (!isLastPage)
                        Button(
                          showButton: showNextButton,
                          text: widget.translations.nextButton,
                          introductionTheme: widget.introductionTheme,
                          onPressed: () async {
                            if (isAnimating) return;
                            isAnimating = true;
                            setState(() {});

                            await controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            isAnimating = false;
                            setState(() {});
                          },
                        ),
                      if (isLastPage)
                        Button(
                          introductionTheme: widget.introductionTheme,
                          showButton: true,
                          text: widget.translations.doneButton,
                          onPressed: () async {
                            await widget.onDone(context);
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
