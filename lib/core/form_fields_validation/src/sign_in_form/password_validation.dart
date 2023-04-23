// 📦 Package imports:
import 'package:formz/formz.dart';

enum SignInPasswordValidationError {
  empty('Password cannot be empty');

  const SignInPasswordValidationError(this.errorText);

  final String errorText;
}

class SignInPasswordInput extends FormzInput<String, SignInPasswordValidationError> {
  const SignInPasswordInput.pure() : super.pure('');

  const SignInPasswordInput.dirty(super.value) : super.dirty();

  @override
  SignInPasswordValidationError? validator(String value) {
    if (value.isEmpty) return SignInPasswordValidationError.empty;
    return null;
  }
}
