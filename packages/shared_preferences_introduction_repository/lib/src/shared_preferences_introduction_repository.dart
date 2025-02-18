import "package:introduction_repository_interface/introduction_repository_interface.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesIntroductionRepository
    implements IntroductionRepositoryInterface {
  bool? _shouldShowIntroduction;

  @override
  Future<List<IntroductionPageData>> fetchIntroductionPages() async => [];

  @override
  Future<void> setCompleted({bool value = true}) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool("_completedIntroduction", value);
  }

  @override
  Future<bool> shouldShow() async {
    if (_shouldShowIntroduction != null) {
      return !_shouldShowIntroduction!;
    }
    var sharedPrefs = await SharedPreferences.getInstance();
    var shouldShow = sharedPrefs.getBool("_completedIntroduction") ?? true;
    _shouldShowIntroduction = shouldShow;
    return !_shouldShowIntroduction!;
  }

  @override
  Future<void> prefetchIntroduction() async {
    await shouldShow();
    await fetchIntroductionPages();
  }
}
