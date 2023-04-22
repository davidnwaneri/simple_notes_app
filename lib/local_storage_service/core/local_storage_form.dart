// 🎯 Dart imports:
import 'dart:collection';

// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/core/local_storage.dart';

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
