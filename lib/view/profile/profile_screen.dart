import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_app/view/authentication/authentication.dart';
import 'package:simple_notes_app/view/profile/widgets/other_profile_screen_widgets.dart';
import 'package:simple_notes_app/view/profile/widgets/profile_card.dart';
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const ProfileCard(user: null),
                        signedIn: (user) => ProfileCard(user: user),
                      );
                    },
                  ),
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
