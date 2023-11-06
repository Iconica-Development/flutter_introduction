// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_data_interface/flutter_data_interface.dart';
import 'package:flutter_introduction_interface/src/local_introduction.dart';

abstract class IntroductionInterface extends DataInterface {
  IntroductionInterface() : super(token: _token);

  static final Object _token = Object();

  static IntroductionInterface _instance = LocalIntroductionDataProvider();

  static IntroductionInterface get instance => _instance;

  static set instance(IntroductionInterface instance) {
    DataInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<void> setCompleted([bool value = true]);

  Future<bool> shouldShow();
}
