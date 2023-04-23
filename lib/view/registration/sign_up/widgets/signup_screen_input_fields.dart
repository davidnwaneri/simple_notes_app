part of '../sign_up_screen.dart';

class FullNameInputField extends StatelessWidget {
  const FullNameInputField({
    required this.controller,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppReusableTextField(
      controller: controller,
      labelText: 'Full Name*',
      outlined: true,
      textInputType: TextInputType.name,
      contentPadding: null,
      validate: true,
      validator: validator,
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    required this.controller,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppReusableTextField(
      controller: controller,
      labelText: 'Email*',
      outlined: true,
      textInputType: TextInputType.emailAddress,
      contentPadding: null,
      validate: true,
      validator: validator,
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    required this.controller,
    required this.validator,
    required this.togglePasswordVisibility,
    required this.hidePassword,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback togglePasswordVisibility;
  final bool hidePassword;

  @override
  Widget build(BuildContext context) {
    return AppReusableTextField(
      controller: controller,
      hideText: hidePassword,
      outlined: true,
      labelText: 'Password*',
      contentPadding: null,
      suffixIcon: IconButton(
        onPressed: togglePasswordVisibility,
        icon: Icon(
          hidePassword ? Icons.visibility : Icons.visibility_off,
          color: context.theme.primaryColor,
        ),
      ),
      validate: true,
      validator: validator,
    );
  }
}

class ConfirmPasswordInputField extends StatelessWidget {
  const ConfirmPasswordInputField({
    required this.controller,
    required this.validator,
    required this.togglePasswordVisibility,
    required this.hidePassword,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback togglePasswordVisibility;
  final bool hidePassword;

  @override
  Widget build(BuildContext context) {
    return AppReusableTextField(
      controller: controller,
      hideText: hidePassword,
      outlined: true,
      labelText: 'Confirm Password*',
      textInputAction: TextInputAction.done,
      contentPadding: null,
      suffixIcon: IconButton(
        onPressed: togglePasswordVisibility,
        icon: Icon(
          hidePassword ? Icons.visibility : Icons.visibility_off,
          color: context.theme.primaryColor,
        ),
      ),
      validate: true,
      validator: validator,
    );
  }
}
