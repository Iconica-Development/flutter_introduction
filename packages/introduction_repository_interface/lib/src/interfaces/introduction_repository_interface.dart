import "package:introduction_repository_interface/introduction_repository_interface.dart";

/// Interface for the introduction repository.
abstract class IntroductionRepositoryInterface {
  Future<List<IntroductionPageData>> fetchIntroductionPages();

  Future<void> setCompleted({bool value = true});

  Future<bool> shouldShow();
}
