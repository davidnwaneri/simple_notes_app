import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<_HidePasswordCubit>(
      // value: _HidePasswordCubit(),
      create: (_) => _HidePasswordCubit(),
      child: const MainSignUpScreen(),
    );
  }
}

class MainSignUpScreen extends StatefulWidget {
  const MainSignUpScreen({super.key});

  @override
  State<MainSignUpScreen> createState() => _MainSignUpScreenState();
}

class _MainSignUpScreenState extends State<MainSignUpScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    context.read<_HidePasswordCubit>().toggle();
  }

  @override
  Widget build(BuildContext context) {
    final hidePassword = context.watch<_HidePasswordCubit>().state;
    return Scaffold(
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
            AppReusableTextField(
              controller: _fullNameController,
              labelText: 'Full Name',
              outlined: true,
              textInputType: TextInputType.name,
              contentPadding: null,
              validate: true,
            ),
            const SizedBox(height: 10),
            AppReusableTextField(
              controller: _emailController,
              labelText: 'Email',
              outlined: true,
              textInputType: TextInputType.emailAddress,
              contentPadding: null,
              validate: true,
            ),
            const SizedBox(height: 10),
            AppReusableTextField(
              controller: _passwordController,
              hideText: hidePassword,
              outlined: true,
              labelText: 'Password',
              contentPadding: null,
              suffixIcon: IconButton(
                onPressed: _togglePasswordVisibility,
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AppReusableTextField(
              controller: _confirmPasswordController,
              hideText: hidePassword,
              outlined: true,
              labelText: 'Confirm Password',
              textInputAction: TextInputAction.done,
              contentPadding: null,
              suffixIcon: IconButton(
                onPressed: _togglePasswordVisibility,
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SignUpButton(
              onTap: () {},
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
