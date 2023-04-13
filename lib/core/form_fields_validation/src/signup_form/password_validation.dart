import 'package:formz/formz.dart';

enum SignUpPasswordValidationError {
  empty('Password cannot be empty'),
  tooShort('Password is too short');

  const SignUpPasswordValidationError(this.errorText);

  final String errorText;
}

class SignUpPasswordInput
    extends FormzInput<String, SignUpPasswordValidationError> {
  const SignUpPasswordInput.pure() : super.pure('');

  const SignUpPasswordInput.dirty(super.value) : super.dirty();

  @override
  SignUpPasswordValidationError? validator(String value) {
    if (value.isEmpty) return SignUpPasswordValidationError.empty;
    if (value.length < 8) return SignUpPasswordValidationError.tooShort;
    return null;
  }
}
