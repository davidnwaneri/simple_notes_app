import 'package:flutter/material.dart';
import 'package:simple_notes_app/view/profile/profile_screen_widgets.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const ReusableSliverAppBar(
            title: 'Profile',
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const ProfileCard(),
                  const SizedBox(height: 30),
                  const ItemTilesArea(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
