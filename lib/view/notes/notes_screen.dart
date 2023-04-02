import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/view/notes/bloc/fetch_notes_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<FetchNotesBloc, FetchNotesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
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
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (context, state) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteTile(
          title: note.title,
          shortInfo: note.body,
          lastModified: note.lastModified,
        );
      },
    );
  }
}

class EmptyNotesScreenView extends StatelessWidget {
  const EmptyNotesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Your notes will appear here.'),
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
    return Center(
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
    );
  }
}
