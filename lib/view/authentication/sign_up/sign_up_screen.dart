import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/form_fields_validation/form_field_validation.dart';
import 'package:simple_notes_app/core/loading_indicator_mixin.dart';
import 'package:simple_notes_app/view/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

part 'widgets/signup_screen_input_fields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<_HidePasswordCubit>(
          create: (_) => _HidePasswordCubit(),
        ),
        BlocProvider<_FormValidationCubit>(
          create: (_) => _FormValidationCubit(),
        ),
      ],
      child: const MainSignUpScreen(),
    );
  }
}

class MainSignUpScreen extends StatefulWidget {
  const MainSignUpScreen({super.key});

  @override
  State<MainSignUpScreen> createState() => _MainSignUpScreenState();
}

class _MainSignUpScreenState extends State<MainSignUpScreen>
    with LoadingIndicatorMixin {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late SignUpForm _signUpForm;

  @override
  void initState() {
    super.initState();
    _signUpForm = SignUpForm();
    _fullNameController = TextEditingController()..addListener(_onNameChanged);
    _emailController = TextEditingController()..addListener(_onEmailChanged);
    _passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
    _confirmPasswordController = TextEditingController()
      ..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _fullNameController
      ..removeListener(_onNameChanged)
      ..dispose();
    _emailController
      ..removeListener(_onEmailChanged)
      ..dispose();
    _passwordController
      ..removeListener(_onPasswordChanged)
      ..dispose();
    _confirmPasswordController
      ..removeListener(_onPasswordChanged)
      ..dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _signUpForm = _signUpForm.copyWith(
      name: NameInput.dirty(_fullNameController.text),
    );
    _checkIsFormValid();
  }

  void _onEmailChanged() {
    _signUpForm = _signUpForm.copyWith(
      email: EmailInput.dirty(_emailController.text),
    );
    _checkIsFormValid();
  }

  void _onPasswordChanged() {
    _signUpForm = _signUpForm.copyWith(
      password: SignUpPasswordInput.dirty(_passwordController.text),
      confirmPassword: ConfirmPasswordInput.dirty(
        _confirmPasswordController.text,
        password: _passwordController.text,
      ),
    );
    _checkIsFormValid();
  }

  void _checkIsFormValid() {
    context.read<_FormValidationCubit>().toggleFormValidation(
          isFormValid: _signUpForm.isValid,
        );
  }

  void _togglePasswordVisibility() {
    context.read<_HidePasswordCubit>().toggle();
  }

  void _submitForm() {
    context.read<SignUpBloc>().add(
          SignUpEventStarted(
            name: _fullNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _signupBlocListener(BuildContext context, SignUpState state) {
    state.maybeWhen(
      orElse: () {},
      loading: showLoadingIndicator,
      success: (user) {
        removeLoadingIndicator();
        context.showSnackBar('Account created successfully!'
            ' Proceed to sign in.');
      },
      failure: (failure) {
        removeLoadingIndicator();
        context.showSnackBar(failure);
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final isFormValid = context.watch<_FormValidationCubit>().state;
    final hidePassword = context.watch<_HidePasswordCubit>().state;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FullNameInputField(
              controller: _fullNameController,
              validator: (_) => _signUpForm.name.displayError?.errorText,
            ),
            const SizedBox(height: 10),
            EmailInputField(
              controller: _emailController,
              validator: (_) => _signUpForm.email.displayError?.errorText,
            ),
            const SizedBox(height: 10),
            PasswordInputField(
              controller: _passwordController,
              hidePassword: hidePassword,
              togglePasswordVisibility: _togglePasswordVisibility,
              validator: (_) => _signUpForm.password.displayError?.errorText,
            ),
            const SizedBox(height: 10),
            ConfirmPasswordInputField(
              controller: _confirmPasswordController,
              hidePassword: hidePassword,
              togglePasswordVisibility: _togglePasswordVisibility,
              validator: (_) =>
                  _signUpForm.confirmPassword.displayError?.errorText,
            ),
            const SizedBox(height: 30),
            BlocListener<SignUpBloc, SignUpState>(
              listener: _signupBlocListener,
              child: SignUpButton(
                onTap: isFormValid ? _submitForm : null,
              ),
            ),
            const SizedBox(height: 30),
            const RedirectToSignInText(),
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: const Text('Sign Up'),
    );
  }
}

class RedirectToSignInText extends StatelessWidget {
  const RedirectToSignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Already have an account? ',
        children: [
          TextSpan(
            text: 'Sign In',
            style: context.textTheme.bodyLarge?.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Go back to the login screen
                context.pop<void>();
              },
          ),
        ],
      ),
    );
  }
}

class _HidePasswordCubit extends Cubit<bool> {
  _HidePasswordCubit() : super(true);

  void toggle() => emit(!state);
}

class _FormValidationCubit extends Cubit<bool> {
  _FormValidationCubit() : super(false);

  void toggleFormValidation({required bool isFormValid}) {
    emit(isFormValid);
  }
}
