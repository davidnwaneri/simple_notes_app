import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HidePasswordCubit>(
      create: (_) => HidePasswordCubit(),
      child: const MainSignInScreen(),
    );
  }
}

class MainSignInScreen extends StatefulWidget {
  const MainSignInScreen({super.key});

  @override
  State<MainSignInScreen> createState() => _MainSignInScreenState();
}

class _MainSignInScreenState extends State<MainSignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    context.read<HidePasswordCubit>().toggle();
  }

  @override
  Widget build(BuildContext context) {
    final hidePassword = context.watch<HidePasswordCubit>().state;
    return Scaffold(
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
            ),
            const SizedBox(height: 30),
            SignInButton(
              onTap: () {},
            ),
            const SizedBox(height: 30),
            const RedirectToSignUpText(),
          ],
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
                //
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
