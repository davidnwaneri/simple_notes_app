// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ReusableSliverAppBar(
            title: note.title ?? 'Untitled',
            leading: BackButton(
              onPressed: () {
                context.pop<void>();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.go(
                    '/notes/${note.id}/edit',
                    extra: note,
                  );
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  Text(
                    note.body,
                    // style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
