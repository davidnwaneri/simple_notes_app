// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/view/authentication/authentication.dart';
import 'package:simple_notes_app/view/notes/bloc/fetch_notes_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

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
              sliver: BlocBuilder<FetchNotesBloc, FetchNotesState>(
                builder: (context, state) {
                  if (!isUserLoggedIn) {
                    return const NotSignedInNotesView();
                  }
                  return state.maybeWhen(
                    orElse: () {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    error: (error) => ErrorView(error: error),
                    loaded: (notes) {
                      if (notes.isEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: notes.length,
        (context, index) {
          final note = notes[index];
          return NoteTile(
            title: note.title ?? note.titleFromBody,
            shortInfo: note.body,
            lastModified: note.lastModified!,
            onTap: () {
              context.push<void>(
                '/notes/${note.id}/details',
                extra: note,
              );
            },
          );
        },
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
