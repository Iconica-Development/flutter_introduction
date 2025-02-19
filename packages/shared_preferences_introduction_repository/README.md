# Flutter Introduction

![Introduction GIF](flutter_introduction_widget.gif)

Monorepo for the Flutter introduction package. Including the following packages:

- <b>flutter_introduction:</b>
  Main package for Flutter Introduction including an example.

- <b>firebase_introduction_repository:</b>
  Package to provide content from firebase.

- <b>introduction_repository_interface:</b>
  Interface regarding data for the Introduction widget, like whether to show the introduction or not.

- <b>shared_preferences_introduction_repository:</b>
  Package to provide content from shared preferences.

## How to use

To use this package, add `flutter_introduction` as a dependency in your pubspec.yaml file. You can get the latest version from [here](https://github.com/Iconica-Development/flutter_introduction).

```yaml
flutter_introduction:
  git:
    url: https://github.com/Iconica-Development/flutter_introduction
    path: packages/flutter_introduction
    version: latest
```

After adding the dependency to your `pubspec.yaml` you can use the widget like this:

```dart
import 'package:flutter_introduction/flutter_introduction.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      onDone: (context) {
        // Do what you want
      },
    );
  }
}
```

The package will work with no additional configuration.
This includes mocked data for the introduction.

To style the introduction, you can use the following parameters:

```dart
IntroductionScreen(
      translations: const IntroductionTranslations(),
      introductionTheme: const IntroductionTheme(),
      options: const IntroductionOptions(),
      onDone: (context) {
        // Do what you want
      },
    );
```

If you want to get the data from Firebase or Shared Preferences, you can use the following code:

```yaml
shared_preferences_introduction_repository:
  git:
    url: https://github.com/Iconica-Development/flutter_introduction
    path: packages/shared_preferences_introduction_repository
    version: latest

firebase_introduction_repository:
  git:
    url: https://github.com/Iconica-Development/flutter_introduction
    path: packages/firebase_introduction_repository
    version: latest
```

```dart
import 'package:firebase_introduction_repository/firebase_introduction_repository.dart';
import 'package:shared_preferences_introduction_repository/shared_preferences_introduction_repository.dart';

IntroductionScreen(
      introductionService: IntroductionService(
        introductionRepositoryInterface:
            SharedPreferencesIntroductionRepository(),
      ),
      onDone: (context) {
        // Do what you want
      },
    );

// Or

IntroductionScreen(
      introductionService: IntroductionService(
        introductionRepositoryInterface:
            FirebaseIntroductionRepository(),
      ),
      onDone: (context) {
        // Do what you want
      },
    );
```

Or you can create your own repository by implementing the `IntroductionRepositoryInterface`.

```dart
class IntroductionRepository implements IntroductionRepositoryInterface {
  @override
  Future<List<IntroductionPageData>> fetchIntroductionPages() async {
    // Get introduction data from source
    throw UnimplementedError();
  }

  @override
  Future<void> setCompleted({bool value = true}) async {
    // Set introduction completed to true or false for the current user
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldShow() async {
    // Check if introduction should be shown for the current user
    throw UnimplementedError();
  }

  @override
  Future<void> prefetchIntroduction() async {
    // Prefetch introduction data. This is optional, this function doesn't get called by the introduction widget. But can be used to prefetch data to show the introduction faster or to skip the introduction faster.
    throw UnimplementedError();
  }
}
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_introduction/pulls) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_introduction/pulls).

## Author

This `flutter_introduction` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
