import "package:introduction_repository_interface/introduction_repository_interface.dart";

class IntroductionService {
  IntroductionService({
    IntroductionRepositoryInterface? introductionRepositoryInterface,
  }) : introductionRepositoryInterface =
            introductionRepositoryInterface ?? LocalIntroductionRepository();

  final IntroductionRepositoryInterface introductionRepositoryInterface;

  Future<List<IntroductionPageData>> fetchIntroductionPages() async =>
      introductionRepositoryInterface.fetchIntroductionPages();

  Future<void> setCompleted({bool value = true}) async =>
      introductionRepositoryInterface.setCompleted(value: value);

  Future<bool> shouldShow() async =>
      introductionRepositoryInterface.shouldShow();

  Future<void> prefetchIntroduction() async =>
      introductionRepositoryInterface.prefetchIntroduction();
}
