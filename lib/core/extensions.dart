import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:simple_notes_app/models/models.dart';

extension Log on Object? {
  void log() => devtools.log(toString());
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
}

extension NoteObjectTitleFromBody on Note {
  String get titleFromBody {
    final nextTitle = body.split(' ');
    if (nextTitle.length > 20) {
      return '${nextTitle.sublist(0, 20).join()}...';
    } else {
      return nextTitle.sublist(0, nextTitle.length).join(' ');
    }
  }
}

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
