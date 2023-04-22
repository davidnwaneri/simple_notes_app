// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class HasEditedNoteCubit extends Cubit<bool> {
  HasEditedNoteCubit() : super(false);

  void toggleHasEditedNote({required bool hasEditedNote}) {
    emit(hasEditedNote);
  }
}

// This widget serves a provider.
// It is used to provide the [HasEditedNoteCubit] to the [MainEditNoteScreen].
class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HasEditedNoteCubit(),
      child: MainEditNoteScreen(note: note),
    );
  }
}

class MainEditNoteScreen extends StatefulWidget {
  const MainEditNoteScreen({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  State<MainEditNoteScreen> createState() => _MainEditNoteScreenState();
}

class _MainEditNoteScreenState extends State<MainEditNoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.note.title,
    );
    _bodyController = TextEditingController(
      text: widget.note.body,
    );

    _titleController.addListener(_toggleHasEdited);
    _bodyController.addListener(_toggleHasEdited);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _toggleHasEdited() {
    final oldTitleIsEqualToNewTitle =
        widget.note.title == _titleController.text;
    final oldBodyIsEqualToNewBody = widget.note.body == _bodyController.text;
    final hasEdited = !(oldTitleIsEqualToNewTitle && oldBodyIsEqualToNewBody);
    context.read<HasEditedNoteCubit>().toggleHasEditedNote(
          hasEditedNote: hasEdited,
        );
  }

  void _onBackButtonPressed() {
    final hasEditedNote = context.read<HasEditedNoteCubit>().state;
    if (!hasEditedNote) {
      context.pop<void>();
      return;
    }
    _showWarningDialogOnPop().then(
          (shouldPop) {
        if (shouldPop != null && shouldPop) {
          context.pop<void>();
        }
      },
    );
  }

  void _onSaveButtonPressed() {
    'Save button pressed'.log();
  }

  Future<bool?> _showWarningDialogOnPop() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
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
    final hasEditedNote = context.watch<HasEditedNoteCubit>().state;
    return WillPopScope(
      onWillPop: () async {
        if (hasEditedNote) {
          final shouldPop = await _showWarningDialogOnPop();
          return shouldPop ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
          leading: BackButton(
            onPressed: _onBackButtonPressed,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: hasEditedNote ? _onSaveButtonPressed : null,
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
                controller: _bodyController,
                expands: true,
                textInputAction: TextInputAction.newline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
