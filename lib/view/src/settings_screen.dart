import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ReusableSliverAppBar(
            title: 'Settings',
            leading: BackButton(
              onPressed: () {
                context.pop<void>();
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('SettingsScreen'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
