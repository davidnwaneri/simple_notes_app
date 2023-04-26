// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/repository/notes_repository.dart';

part 'edit_note_state.dart';
part 'edit_note_event.dart';

part 'edit_note_bloc.freezed.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  EditNoteBloc({
    required NotesRepository repository,
  })  : _repository = repository,
        super(const EditNoteState.initial()) {
    on<EditNoteStarted>(_onEditNoteStarted);
  }

  final NotesRepository _repository;

  Future<void> _onEditNoteStarted(
    EditNoteStarted event,
    Emitter<EditNoteState> emit,
  ) async {
    emit(const EditNoteState.inProgress());
    final res = await _repository.editNote(event.note);
    res.fold(
      (l) => emit(EditNoteState.failure(message: l.message)),
      (r) => emit(const EditNoteState.success()),
    );
  }
}
