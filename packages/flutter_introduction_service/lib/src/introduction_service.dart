// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/flutter_introduction_interface.dart';

class IntroductionService {
  IntroductionService([IntroductionInterface? dataProvider])
      : _dataProvider = dataProvider ?? LocalIntroductionDataProvider();

  late final IntroductionInterface _dataProvider;

  Future<void> onSkip() {
    return _dataProvider.setCompleted(true);
  }

  Future<void> onComplete() {
    return _dataProvider.setCompleted(true);
  }

  Future<bool> shouldShow() {
    return _dataProvider.shouldShow();
  }
}
