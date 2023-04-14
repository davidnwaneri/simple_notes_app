import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/form_fields_validation/form_field_validation.dart';
import 'package:simple_notes_app/core/loading_indicator_mixin.dart';
import 'package:simple_notes_app/view/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HidePasswordCubit>(
          create: (_) => HidePasswordCubit(),
        ),
        BlocProvider<_FormValidationCubit>(
          create: (_) => _FormValidationCubit(),
        ),
      ],
      child: const MainSignInScreen(),
    );
  }
}

class MainSignInScreen extends StatefulWidget {
  const MainSignInScreen({super.key});

  @override
  State<MainSignInScreen> createState() => _MainSignInScreenState();
}

class _MainSignInScreenState extends State<MainSignInScreen>
    with LoadingIndicatorMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late SignInForm _signInForm;

  @override
  void initState() {
    super.initState();
    _signInForm = SignInForm();
    _emailController = TextEditingController()..addListener(_onEmailChanged);
    _passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController
      ..removeListener(_onEmailChanged)
      ..dispose();
    _passwordController
      ..removeListener(_onPasswordChanged)
      ..dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signInForm = _signInForm.copyWith(
      email: EmailInput.dirty(_emailController.text),
    );
    _checkIsFormValid();
  }

  void _onPasswordChanged() {
    _signInForm = _signInForm.copyWith(
      password: SignInPasswordInput.dirty(_passwordController.text),
    );
    _checkIsFormValid();
  }

  void _checkIsFormValid() {
    context.read<_FormValidationCubit>().toggleFormValidation(
          isFormValid: _signInForm.isValid,
        );
  }

  void _togglePasswordVisibility() {
    context.read<HidePasswordCubit>().toggle();
  }

  void _submitForm() {
    _dismissKeyboard();
    context.read<SignInBloc>().add(
          SignInEventStarted(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _signInBlocListener(BuildContext context, SignInState state) {
    state.maybeWhen(
      orElse: () {},
      loading: showLoadingIndicator,
      success: (session) {
        removeLoadingIndicator();
        context.showSnackBar('Signed in successfully');
        'UserSession: $session'.log();
      },
      error: (error) {
        removeLoadingIndicator();
        context.showSnackBar(error);
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final hidePassword = context.watch<HidePasswordCubit>().state;
    final isFormValid = context.watch<_FormValidationCubit>().state;
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sign In'),
          leading: const BackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppReusableTextField(
                controller: _emailController,
                labelText: 'Email',
                outlined: true,
                textInputType: TextInputType.emailAddress,
                contentPadding: null,
                validate: true,
                validator: (_) => _signInForm.email.displayError?.errorText,
              ),
              const SizedBox(height: 10),
              AppReusableTextField(
                controller: _passwordController,
                hideText: hidePassword,
                outlined: true,
                labelText: 'Password',
                textInputAction: TextInputAction.done,
                contentPadding: null,
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: context.theme.primaryColor,
                  ),
                ),
                validate: true,
                validator: (_) => _signInForm.password.displayError?.errorText,
              ),
              const SizedBox(height: 30),
              BlocListener<SignInBloc, SignInState>(
                listener: _signInBlocListener,
                child: SignInButton(
                  onTap: isFormValid ? _submitForm : null,
                ),
              ),
              const SizedBox(height: 30),
              const RedirectToSignUpText(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
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
      child: const Text('Sign In'),
    );
  }
}

class RedirectToSignUpText extends StatelessWidget {
  const RedirectToSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Don't have an account? ",
        children: [
          TextSpan(
            text: 'Sign Up',
            style: context.textTheme.bodyLarge?.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/auth/sign-up');
              },
          ),
        ],
      ),
    );
  }
}

class HidePasswordCubit extends Cubit<bool> {
  HidePasswordCubit() : super(true);

  void toggle() => emit(!state);
}

class _FormValidationCubit extends Cubit<bool> {
  _FormValidationCubit() : super(false);

  void toggleFormValidation({required bool isFormValid}) {
    emit(isFormValid);
  }
}
