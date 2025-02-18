import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:introduction_repository_interface/introduction_repository_interface.dart";

class FirebaseIntroductionRepository
    implements IntroductionRepositoryInterface {
  bool? _shouldShowIntroduction;
  List<IntroductionPageData>? _introductionPages;

  final _introductionCollection = FirebaseFirestore.instance
      .collection("flutter_introduction")
      .doc("flutter_introduction");

  @override
  Future<List<IntroductionPageData>> fetchIntroductionPages() async {
    if (_introductionPages != null) {
      return _introductionPages!;
    }
    try {
      var introductionPagesData = await _introductionCollection
          .collection("pages")
          .withConverter(
            fromFirestore: (snapshot, _) => IntroductionPageData.fromJson(
              snapshot.data()!,
            ),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      var introductionPages =
          introductionPagesData.docs.map((e) => e.data()).toList();

      introductionPages.sort((a, b) => a.id.compareTo(b.id));
      _introductionPages = introductionPages;
      return introductionPages;
    } on Exception catch (_) {
      throw Exception();
    }
  }

  @override
  Future<void> setCompleted({bool value = true}) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      var deviceId = await _getDeviceId();
      if (deviceId == null) {
        throw Exception("Failed to get device id");
      }
      await _introductionCollection.collection("devices").doc(deviceId).set({
        "introduction_completed": value,
      });
    } catch (e) {
      throw Exception("Failed to set introduction completed: $e");
    }
  }

  @override
  Future<bool> shouldShow() async {
    if (_shouldShowIntroduction != null) {
      return _shouldShowIntroduction!;
    }
    try {
      await FirebaseAuth.instance.signInAnonymously();
      var deviceId = await _getDeviceId();
      if (deviceId == null) {
        throw Exception("Failed to get device id");
      }
      var introductionCompleted = await _introductionCollection
          .collection("devices")
          .doc(deviceId)
          .get();
      if (!introductionCompleted.exists) {
        return true;
      }
      _shouldShowIntroduction =
          // ignore: avoid_dynamic_calls
          !introductionCompleted.data()!["introduction_completed"];
      return _shouldShowIntroduction!;
    } on Exception catch (_) {
      throw Exception();
    }
  }

  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  @override
  Future<void> prefetchIntroduction() async {
    await shouldShow();
    await fetchIntroductionPages();
  }
}
