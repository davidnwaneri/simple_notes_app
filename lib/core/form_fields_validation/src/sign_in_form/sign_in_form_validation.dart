// 📦 Package imports:
import 'package:formz/formz.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/form_fields_validation/src/email_validation.dart';
import 'package:simple_notes_app/core/form_fields_validation/src/sign_in_form/password_validation.dart';

class SignInForm with FormzMixin {
  SignInForm({
    this.email = const EmailInput.pure(),
    this.password = const SignInPasswordInput.pure(),
  });

  final EmailInput email;
  final SignInPasswordInput password;

  @override
  List<FormzInput> get inputs => [email, password];

  SignInForm copyWith({
    EmailInput? email,
    SignInPasswordInput? password,
  }) {
    return SignInForm(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
