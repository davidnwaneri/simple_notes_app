// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flex_color_scheme/flex_color_scheme.dart';

abstract class IAppTheme {
  ThemeData get darkTheme;

  ThemeData get lightTheme;

  factory IAppTheme.withFlexColorScheme() {
    return AppThemeWithFlexColorScheme();
  }
}

class AppThemeWithFlexColorScheme implements IAppTheme {
  const AppThemeWithFlexColorScheme();

  @override
  ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.espresso,
    );
  }

  @override
  ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.espresso,
    );
  }
}
