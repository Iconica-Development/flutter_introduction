// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/flutter_introduction_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides data storage using SharedPreferences for
/// managing introduction data.
///
/// This class extends [IntroductionInterface] and implements methods to manage
/// introduction data using SharedPreferences.
class SharedPreferencesIntroductionDataProvider extends IntroductionInterface {
  /// Constructs an instance of [SharedPreferencesIntroductionDataProvider].
  SharedPreferencesIntroductionDataProvider();

  SharedPreferences? _prefs;
  String key = '_completedIntroduction';

  /// Writes a key-value pair to SharedPreferences.
  ///
  /// The [key] is the key under which to store the [value].
  /// The [value] is the boolean value to be stored.
  Future<void> _writeKeyValue(String key, bool value) async {
    await _prefs!.setBool(key, value);
  }

  /// Initializes the SharedPreferences instance.
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
