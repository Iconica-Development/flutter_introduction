// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/flutter_introduction_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesIntroductionDataProvider extends IntroductionInterface {
  SharedPreferencesIntroductionDataProvider();

  SharedPreferences? _prefs;
  String key = '_completedIntroduction';

  Future<void> _writeKeyValue(String key, bool value) async {
    await _prefs!.setBool(key, value);
  }

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> setCompleted({bool value = true}) async {
    await _init();
    await _writeKeyValue(key, value);
  }

  @override
  Future<bool> shouldShow() async {
    await _init();
    return !(_prefs!.getBool(key) ?? false);
  }
}
