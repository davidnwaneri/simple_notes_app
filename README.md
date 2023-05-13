# SimpleNotes

SimpleNotes is a Flutter project that provides a simple note-taking application with authentication and data
synchronization features using [Appwrite](https://appwrite.io/). The app is designed to allow users to create and store
notes in a secure and organized manner.

https://github.com/davidnwaneri/simple_notes_app/assets/48889672/3bb37c7d-1f9e-4c5e-a659-7411cc62d1cf





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
2. Run `flutter pub get` to install the project dependencies.
3. Run build_runner to generate the code for the freezed classes:

```sh
flutter pub run build_runner build
```

5. Create a new Appwrite project and configure the project settings. (See
   the [Setting up Appwrite](#setting-up-appwrite) section)


6. Run the app using the command:

```sh
flutter run --dart-define=APPWRITE_ENDPOINT=[your_appwrite_endpoint_url] --dart-define=APPWRITE_PROJECT_ID=[your_appwrite_project_id] --dart-define=APPWRITE_NOTE_DATABASE_ID=[database-id] --dart-define=APPWRITE_NOTE_COLLECTION_ID=[collection-id]
```

## Setting up Appwrite

To use Appwrite with SimpleNotes, you need to create a new Appwrite project and configure the project settings.
Note: Appwrite is packaged as a set of Docker images, so you need to have Docker installed on your machine to run
Appwrite. Once that is done, proceed with the following steps:

1. Open your browser and access the Appwrite console at localhost
2. Create an account and sign in.
3. Create a new project by clicking the `Create Project` button on the Appwrite dashboard.
4. In the `Overview` tab, scroll down to the `Integrations` section and add a platform by clicking the `Add Platform`
   button. Select `Flutter App` from the list, and then proceed to register your flutter app for the whatever
   environment
   your flutter app will run on (Android, iOS, Web, etc.).
5. Confirm that `Email/Password` authentication method is enabled by going to the settings section of the `Auth` tab.
6. Retrieve the project ID from the project settings page and set it as the `APPWRITE_PROJECT_ID` environment variable.
   And also the endpoint URL and set it as the `APPWRITE_ENDPOINT` environment variable.
   Note: When running on Android you may need to use the IP address of your machine instead of localhost as the endpoint
   URL.
7. Create a new database by going to the `Database` tab and then proceed to retrieve the database ID and set it as
   the `APPWRITE_NOTE_DATABASE_ID` environment variable.
8. Create a new collection by clicking on the newly created database and then clicking `Create Collection`. Proceed to
   retrieve the collection ID and set it as the `APPWRITE_NOTE_COLLECTION_ID` environment variable.
9. In the newly created collection, go to the `Attributes` section and create the following attributes:
    - (String) [Attribute Key]: `title` || [Size]: 40 || [Default value]: [empty][Null]
    - (String) [Attribute Key]: `body` || [Size]: 2000 || [Required]: true
    - (String) [Attribute Key]: `id` || [Size]: 40 || [Required]: true
    - (String) [Attribute Key]: `ownedId` || [Size]: 40 || [Required]: true
10. Do not forget to enable `CREATE`, `READ`, `UPDATE` and `DELETE` permissions for the created collection by navigating to the settings section of the collection.

For more information on how to use Appwrite, check out the [Appwrite documentation](https://appwrite.io/docs).

Note: The --dart-define flag allows you to pass environment variables to your Flutter app at runtime. Make sure to
replace [your_appwrite_endpoint_url], [your_appwrite_project_id], [database-id], and [collection-id] with the
appropriate values.

## License
This project is licensed under the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/) License - see the LICENSE file for details.

The GNU GPLv3 is a free and open-source software license that gives users the freedom to use, modify, and distribute the software as they see fit, as long as they also distribute the modified software under the same license. If you choose to use this project or any of its code, please make sure to read and understand the terms of the license.

## Contributing

Contributions of all kinds are welcome and encouraged! Whether you want to report a bug, submit a feature request, or make changes to the code, we value your input and appreciate your help in making SimpleNotes better.
