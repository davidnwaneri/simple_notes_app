// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/models.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.user,
    super.key,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    final userIsSignedIn = user != null;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 32,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(
                Icons.account_circle_rounded,
              ),
            ),
            const SizedBox(width: 10),
            if (userIsSignedIn)
              SignedInUserProfileInfo(user: user!)
            else
              const UserNotSignedInProfileInfo(),
          ],
        ),
      ),
    );
  }
}

class SignedInUserProfileInfo extends StatelessWidget {
  const SignedInUserProfileInfo({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: context.theme.textButtonTheme.style?.textStyle?.resolve({
            ...MaterialState.values,
          }),
        ),
        Text(user.email),
      ],
    );
  }
}

class UserNotSignedInProfileInfo extends StatelessWidget {
  const UserNotSignedInProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            context.push('/auth/sign-in');
          },
          child: Text(
            'Sign In',
            style: context.theme.textButtonTheme.style?.textStyle?.resolve({
              ...MaterialState.values,
            })?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const Text(
          'Back up, Sync',
        ),
      ],
    );
  }
}
