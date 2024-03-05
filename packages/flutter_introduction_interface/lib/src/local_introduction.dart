// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/src/introduction_interface.dart';

/// Provides local data storage for managing introduction data.
///
/// This class extends [IntroductionInterface] and implements methods to manage
/// introduction data locally.
class LocalIntroductionDataProvider extends IntroductionInterface {
  /// Constructs an instance of [LocalIntroductionDataProvider].
  ///
  /// Initializes the [hasViewed] flag to `false`.
  LocalIntroductionDataProvider();

  /// Flag indicating whether the introduction has been viewed or not.
  bool hasViewed = false;

  @override
  Future<void> setCompleted({bool value = true}) async {
    hasViewed = value;
  }

  @override
  Future<bool> shouldShow() async => hasViewed;
}
