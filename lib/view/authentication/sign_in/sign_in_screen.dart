import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/loading_indicator_mixin.dart';
import 'package:simple_notes_app/view/authentication/sign_in/bloc/sign_in_bloc.dart';
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

class _MainSignInScreenState extends State<MainSignInScreen>
    with LoadingIndicatorMixin {
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
              BlocListener<SignInBloc, SignInState>(
                listener: _signInBlocListener,
                child: SignInButton(
                  onTap: () {
                    _dismissKeyboard();
                    context.read<SignInBloc>().add(
                          SignInEventStarted(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
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
