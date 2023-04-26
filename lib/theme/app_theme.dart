// 🐦 Flutter imports:

// 📦 Package imports:
import 'package:flex_color_scheme/flex_color_scheme.dart';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class AppThemeWithFlexColorScheme {
  const AppThemeWithFlexColorScheme();

  ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.espresso,
    );
  }

  ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.espresso,
    );
  }
}
