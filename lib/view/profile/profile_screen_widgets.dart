import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/extensions.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sign In',
                    style: context.theme.textButtonTheme.style?.textStyle
                        ?.resolve({
                      ...MaterialState.values,
                    })?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text('Back up, Sync'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTilesArea extends StatelessWidget {
  const ItemTilesArea({
    super.key,
  });

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
            onTap: () {},
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
