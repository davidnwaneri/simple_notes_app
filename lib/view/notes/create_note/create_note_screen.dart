// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/loading_indicator_mixin.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/view/notes/create_note/bloc/create_note_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen>
    with LoadingIndicatorMixin {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createNote() {
    if (_descriptionController.text.isNotEmpty) {
      final note = Note(
        title: _titleController.text,
        body: _descriptionController.text,
      );
      _dismissKeyboard();
      context.read<CreateNoteBloc>().add(CreateNoteStarted(note: note));
    }
  }

  void _createBlocListener(BuildContext context, CreateNoteState state) {
    state.maybeWhen(
      orElse: () {},
      loading: showLoadingIndicator,
      success: () {
        removeLoadingIndicator();
        showSuccessIndicator(
          message: 'Note created successfully',
          onDismissed: () => context.pop<void>(),
        );
      },
      failure: (message) {
        removeLoadingIndicator();
        context.showSnackBar(message);
      },
    );
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        leading: const BackButton(),
        actions: [
          BlocListener<CreateNoteBloc, CreateNoteState>(
            listener: _createBlocListener,
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: _createNote,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          AppReusableTextField(
            controller: _titleController,
            hintText: 'Title',
          ),
          Expanded(
            child: AppReusableTextField(
              controller: _descriptionController,
              hintText: 'Description',
              expands: true,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }
}
