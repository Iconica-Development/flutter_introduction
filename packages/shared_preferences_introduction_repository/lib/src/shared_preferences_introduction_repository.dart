import "package:introduction_repository_interface/introduction_repository_interface.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesIntroductionRepository
    implements IntroductionRepositoryInterface {
  @override
  Future<List<IntroductionPageData>> fetchIntroductionPages() async {
    throw Exception();
  }

  @override
  Future<void> setCompleted({bool value = true}) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool("_completedIntroduction", value);
  }

  @override
  Future<bool> shouldShow() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    var shouldShow = sharedPrefs.getBool("_completedIntroduction") ?? true;
    return !shouldShow;
  }
}
