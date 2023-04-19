import 'dart:collection';

import 'package:simple_notes_app/core/local_storage/local_storage.dart';
import 'package:simple_notes_app/core/typedefs.dart';

class LocalStorageForm {
  LocalStorageForm({
    required UnmodifiableListView<ILocalStorageService> localStorageServices,
  }) : _localStorageServices = localStorageServices;

  final UnmodifiableListView<ILocalStorageService> _localStorageServices;

  FutureVoid clearAll() async {
    for (final service in _localStorageServices) {
      await service.clear();
    }
  }
}
