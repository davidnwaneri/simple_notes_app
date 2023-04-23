// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/view/authentication/sign_in/bloc/auth/auth_bloc.dart';

class ItemTilesArea extends StatelessWidget {
  const ItemTilesArea({
    super.key,
  });

  void _logOut(BuildContext context) {
    final sigInBloc = context.read<AuthBloc>();
    sigInBloc.state.maybeWhen(
      signedIn: (_) {
        context.read<AuthBloc>().add(const UserSignedOut());
      },
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          ItemTile(
            icon: Icons.settings_suggest,
            title: 'Settings',
            onTap: () {
              context.push('/profile/settings');
            },
          ),
          ItemTile(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onTap: () => _logOut(context),
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
      ),
    );
  }
}
