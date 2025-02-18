import "package:introduction_repository_interface/introduction_repository_interface.dart";

class LocalIntroductionRepository implements IntroductionRepositoryInterface {
  var _completed = false;
  @override
  Future<void> setCompleted({bool value = true}) async {
    _completed = value;
  }

  @override
  Future<bool> shouldShow() async => !_completed;

  @override
  Future<List<IntroductionPageData>> fetchIntroductionPages() {
    throw Exception();
  }
}
