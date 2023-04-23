// 🎯 Dart imports:
import 'dart:developer' as devtools show log;

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
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

extension DateTimeToTimeAgoExtension on DateTime {
  String toTimeAgo() {
    final difference = DateTime.now().difference(this);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      final differenceInDays = difference.inDays;
      final days = differenceInDays > 1 ? 'days' : 'day';
      return '$differenceInDays $days ago';
    } else if (difference.inHours > 0) {
      final differenceInHours = difference.inHours;
      final hours = differenceInHours > 1 ? 'hours' : 'hour';
      return '$differenceInHours $hours ago';
    } else if (difference.inMinutes > 0) {
      final differenceInMinutes = difference.inMinutes;
      final minutes = differenceInMinutes > 1 ? 'minutes' : 'minute';
      return '$differenceInMinutes $minutes ago';
    } else {
      return 'Just now';
    }
  }
}
