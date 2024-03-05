// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_data_interface/flutter_data_interface.dart';
import 'package:flutter_introduction_interface/src/local_introduction.dart';

abstract class IntroductionInterface extends DataInterface {
  /// Constructs an instance of [IntroductionInterface].
  ///
  /// The [token] is used for verification purposes.
  IntroductionInterface() : super(token: _token);

  static final Object _token = Object();

  static IntroductionInterface _instance = LocalIntroductionDataProvider();

  /// Retrieves the current instance of [IntroductionInterface].
  static IntroductionInterface get instance => _instance;

  /// Sets the current instance of [IntroductionInterface].
  ///
  /// Throws an error if the provided instance does not match the token.
  static set instance(IntroductionInterface instance) {
    DataInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Sets whether the introduction is completed or not.
  ///
  /// The [value] parameter specifies whether the introduction is completed.
  /// By default, it is set to `true`.
  Future<void> setCompleted({bool value = true});

  /// Checks if the introduction should be shown.
  ///
  /// Returns `true` if the introduction should be shown;
  /// otherwise, returns `false`.
  Future<bool> shouldShow();
}
