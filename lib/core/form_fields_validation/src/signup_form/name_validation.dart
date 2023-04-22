// 📦 Package imports:
import 'package:formz/formz.dart';

enum NameValidationError {
  empty('Name is required'),
  tooShort('Try something longer');

  const NameValidationError(this.errorText);

  final String errorText;
}

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');

  const NameInput.dirty(super.value) : super.dirty();

  @override
  NameValidationError? validator(String? value) {
    if (value != null && value.isEmpty) {
      return NameValidationError.empty;
    }
    if (value != null && value.length < 4) {
      return NameValidationError.tooShort;
    }
    return null;
  }
}
