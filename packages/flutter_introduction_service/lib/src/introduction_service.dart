// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_introduction_interface/flutter_introduction_interface.dart';

/// A service for managing introduction-related operations.
///
/// This class provides methods for handling introduction-related actions
/// such as skipping, completing,
/// and determining whether to show the introduction.
class IntroductionService {
  /// Constructs an instance of [IntroductionService].
  ///
  /// Optionally takes a [dataProvider] parameter,
  /// which is an implementation of [IntroductionInterface].
  /// If no data provider is provided,
  /// it defaults to [LocalIntroductionDataProvider].
  IntroductionService([IntroductionInterface? dataProvider])
      : _dataProvider = dataProvider ?? LocalIntroductionDataProvider();

  late final IntroductionInterface _dataProvider;

  /// Marks the introduction as skipped.
  ///
  /// Calls [_dataProvider.setCompleted] with the value `true`.
  Future<void> onSkip() => _dataProvider.setCompleted(value: true);

  /// Marks the introduction as completed.
  ///
  /// Calls [_dataProvider.setCompleted] with the value `true`.
  Future<void> onComplete() => _dataProvider.setCompleted(value: true);

  /// Checks whether the introduction should be shown.
  ///
  /// Returns a `Future<bool>` indicating whether the
  /// introduction should be shown.
  Future<bool> shouldShow() => _dataProvider.shouldShow();
}
