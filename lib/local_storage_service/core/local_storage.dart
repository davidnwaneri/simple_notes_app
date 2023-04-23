// 📦 Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';

abstract class ILocalStorageService {
  FutureEitherVoid save({required String key, required String value});

  Option<String> read(String key);

  FutureEitherVoid delete(String key);

  FutureVoid clear();
}

class LocalStorageServiceWithSharedPref implements ILocalStorageService {
  LocalStorageServiceWithSharedPref({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final SharedPreferences _plugin;

  @override
  FutureEitherVoid save({required String key, required String value}) async {
    try {
      final valueSaved = await _plugin.setString(key, value);
      if (!valueSaved) {
        return left(
          SaveDataFailure('Failed to save data'),
        );
      }
      return right(unit);
    } catch (e, st) {
      return left(
        SaveDataFailure(
          e.toString(),
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Option<String> read(String key) {
    final value = _plugin.getString(key);
    if (value == null) return none();
    return some(value);
  }

  @override
  FutureEitherVoid delete(String key) async {
    try {
      final dataDeleted = await _plugin.remove(key);
      if (!dataDeleted) {
        return left(
          DeleteDataFailure('Failed to delete data'),
        );
      }
      return right(unit);
    } catch (e, st) {
      return left(
        DeleteDataFailure(
          e.toString(),
          stackTrace: st,
        ),
      );
    }
  }

  @override
  FutureVoid clear() async {
    await _plugin.clear();
  }
}
