// 🐦 Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/repository/notes_repository.dart';
import 'package:simple_notes_app/view/authentication/authentication.dart';
import 'package:simple_notes_app/view/notes/delete_note/bloc/delete_note_bloc.dart';
import 'package:simple_notes_app/view/notes/notes_screen/bloc/fetch_notes_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    final notesRepo = RepositoryProvider.of<NotesRepository>(context);
    unawaited(notesRepo.fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          signedIn: (_) => true,
        );
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 100,
        onRefresh: () async {
          if (isUserLoggedIn) {
            context.read<FetchNotesBloc>().add(const NotesFetched());
          }
        },
        child: CustomScrollView(
          slivers: [
            const ReusableSliverAppBar(
              title: 'Notes',
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: Builder(
                builder: (context) {
                  if (!isUserLoggedIn) {
                    return const NotSignedInNotesView();
                  }
                  final notesRepo = context.read<NotesRepository>();
                  return StreamBuilder<List<Note>>(
                    initialData: notesRepo.currentNotes,
                    stream: notesRepo.streamNotes,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Note>> snapshot) {
                      final notes = snapshot.requireData;
                      if (notes == invalidNotes) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (notes.isEmpty) {
                        return const EmptyNotesScreenView();
                      }
                      return NotesScreenListView(notes: notes);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotSignedInNotesView extends StatelessWidget {
  const NotSignedInNotesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final navBarHeight = MediaQuery.of(context).padding.bottom;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: maxHeight / 2 - statusBarHeight - navBarHeight,
              child: const Text('Please sign in to see your notes.'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesScreenListView extends StatelessWidget {
  const NotesScreenListView({
    required this.notes,
    super.key,
  });

  final List<Note> notes;

  void _onDeleteNote({
    required BuildContext context,
    required Note note,
  }) {
    context.read<DeleteNoteBloc>().add(DeleteNoteStarted(note: note));
    context.read<FetchNotesBloc>().add(const NotesFetched());
  }

  Future<bool?> _showConfirmDialogOnDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete note?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop<bool>(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.pop<bool>(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: notes.length,
        (context, index) {
          final note = notes[index];
          return Dismissible(
            key: ValueKey(note.id),
            direction: DismissDirection.endToStart,
            background: const DismissibleBackground(
              icon: Icons.delete,
              color: Colors.red,
            ),
            onDismissed: (_) => _onDeleteNote(
              context: context,
              note: note,
            ),
            confirmDismiss: (_) => _showConfirmDialogOnDelete(context),
            child: NoteTile(
              title: note.title ?? note.titleFromBody,
              shortInfo: note.body,
              lastModified: note.lastModified!,
              onTap: () {
                context.push<void>(
                  '/notes/${note.id}/details',
                  extra: note,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    required this.icon,
    required this.color,
    super.key,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyNotesScreenView extends StatelessWidget {
  const EmptyNotesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text('Your notes will appear here.'),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.error,
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            ElevatedButton(
              onPressed: () {
                context.read<FetchNotesBloc>().add(const NotesFetched());
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
