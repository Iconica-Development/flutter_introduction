// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/src/introduction_interface.dart';

class LocalIntroductionDataProvider extends IntroductionInterface {
  LocalIntroductionDataProvider();

  bool hasViewed = false;

  @override
  Future<void> setCompleted([bool value = true]) async {
    hasViewed = value;
  }

  @override
  Future<bool> shouldShow() async {
    return hasViewed;
  }
}
