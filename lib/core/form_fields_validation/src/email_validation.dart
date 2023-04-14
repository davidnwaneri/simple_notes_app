import 'package:formz/formz.dart';

enum EmailValidationError {
  empty('Email address is required'),
  invalid('Enter a valid email address');

  const EmailValidationError(this.errorText);

  final String errorText;
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');

  const EmailInput.dirty(super.value) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!_isValidEmail(value)) return EmailValidationError.invalid;
    return null;
  }

  static bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
