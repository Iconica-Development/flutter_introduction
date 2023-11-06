// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

library flutter_introduction_shared_preferences;

import 'package:flutter_introduction_interface/flutter_introduction_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesIntroductionDataProvider extends IntroductionInterface {
  SharedPreferencesIntroductionDataProvider();

  SharedPreferences? _prefs;
  String key = '_completedIntroduction';

  _writeKeyValue(String key, bool value) async {
    _prefs!.setBool(key, value);
  }

  _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> setCompleted([bool value = true]) async {
    await _init();
    _writeKeyValue(key, value);
  }

  @override
  Future<bool> shouldShow() async {
    await _init();
    return !(_prefs!.getBool(key) ?? false);
  }
}
