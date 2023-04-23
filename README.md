# SimpleNotes

SimpleNotes is a Flutter project that provides a simple note-taking application with authentication and data
synchronization features using [Appwrite](https://appwrite.io/). The app is designed to allow users to create and store
notes in a secure and organized manner.

<video width="100%" src="https://user-images.githubusercontent.com/48889672/233867067-461fbf77-f07f-4cfe-b1ba-50fdde3b64fb.mp4" alt="Simple Note App"></video>

## Dependencies

The following dependencies were used in the development of this project:

- [`appwrite`](https://pub.dev/packages/appwrite): a Flutter SDK for the Appwrite server.
- [`equatable`](https://pub.dev/packages/equatable): a utility library for implementing equality without needing to
  explicitly override == and hashCode methods.
- [`flex_color_scheme`](https://pub.dev/packages/flex_color_scheme): a Flutter package that provides customizable color
  schemes for Flutter apps.
- `flutter`: the core Flutter SDK.
- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc): a Flutter package that implements the BLoC (Business Logic
  Component) pattern to manage state in Flutter apps.
- [`formz`](https://pub.dev/packages/formz): a Flutter package that simplifies form validation and management.
- [`fpdart`](https://pub.dev/packages/fpdart): a collection of functional programming utilities for Dart.
- [`freezed_annotation`](https://pub.dev/packages/freezed_annotation): a package that generates immutable classes for
  Dart with the freezed library.
- [`go_router`](https://pub.dev/packages/go_router): a declarative and flexible router for Flutter apps.
- [`hydrated_bloc`](https://pub.dev/packages/hydrated_bloc): a Flutter package that adds support for state persistence
  to flutter_bloc.
- [`json_annotation`](https://pub.dev/packages/json_annotation): a package that generates JSON serialization and
  deserialization code for Dart classes.
- [`lottie`](https://pub.dev/packages/lottie): a Flutter package that provides support for Lottie animations.
- [`path_provider`](https://pub.dev/packages/path_provider): a Flutter package that provides platform-specific locations
  for storing files.
- [`shared_preferences`](https://pub.dev/packages/shared_preferences): a Flutter package that provides a persistent
  store for simple data.
- [`timeago`](https://pub.dev/packages/timeago): a Flutter package that provides human-readable time intervals.

## Development Dependencies

The following development dependencies were used in the development of this project:

- [`build_runner`](https://pub.dev/packages/build_runner): a command-line tool for generating Dart code based on
  annotated source code.
- `flutter_test`: the Flutter testing framework.
- [`freezed`](https://pub.dev/packages/freezed): a code generator for generating immutable classes in Dart with the
  freezed library.
- [`json_serializable`](https://pub.dev/packages/json_serializable): a code generator for generating JSON serialization
  and deserialization code for Dart classes.
- [`very_good_analysis`](https://pub.dev/packages/very_good_analysis): a Flutter package that provides static analysis
  tools and style enforcement for Flutter projects.

## Getting Started

To get started with SimpleNotes, follow these steps:

1. Clone the repository to your local machine.
2. Create a new Appwrite project and configure the project settings.
3. Run `flutter pub get` to install the project dependencies.
4. Run build_runner to generate the code for the freezed classes:

```sh
flutter pub run build_runner build
```

5. Run the app using the command:

```sh
flutter run --dart-define=APPWRITE_ENDPOINT=[your_appwrite_endpoint_url] --dart-define=APPWRITE_PROJECT_ID=[your_appwrite_project_id]
```

## Conclusion

SimpleNotes is a simple and elegant note-taking app that provides a secure and reliable way to store notes. The app is
built with Flutter and integrates with Appwrite for data synchronization and authentication. The dependencies used in
the development of this project provide a robust and efficient foundation for building Flutter apps.

