import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';

extension Log on Object? {
  void log() => devtools.log(toString());
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
}
