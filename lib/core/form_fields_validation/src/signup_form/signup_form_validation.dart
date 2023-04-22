// 📦 Package imports:
import 'package:formz/formz.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/form_fields_validation/src/email_validation.dart';
import 'package:simple_notes_app/core/form_fields_validation/src/signup_form/confirm_password_validation.dart';
import 'package:simple_notes_app/core/form_fields_validation/src/signup_form/name_validation.dart';
import 'package:simple_notes_app/core/form_fields_validation/src/signup_form/password_validation.dart';

class SignUpForm with FormzMixin {
  SignUpForm({
    this.name = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const SignUpPasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
  });

  final NameInput name;
  final EmailInput email;
  final SignUpPasswordInput password;
  final ConfirmPasswordInput confirmPassword;

  @override
  List<FormzInput> get inputs => [
        name,
        email,
        password,
        confirmPassword,
      ];

  SignUpForm copyWith({
    NameInput? name,
    EmailInput? email,
    SignUpPasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
  }) {
    return SignUpForm(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
