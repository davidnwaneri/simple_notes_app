import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  mismatch('Password does not match');

  const ConfirmPasswordValidationError(this.errorText);

  final String errorText;
}

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPasswordInput.pure({
    this.password = '',
  }) : super.pure('');

  const ConfirmPasswordInput.dirty(
    super.value, {
    required this.password,
  }) : super.dirty();

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }
}
