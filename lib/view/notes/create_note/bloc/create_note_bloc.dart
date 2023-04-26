// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/models/src/note/note.dart';
import 'package:simple_notes_app/repository/notes_repository.dart';
import 'package:simple_notes_app/repository/repository.dart';
import 'package:uuid/uuid.dart';

part 'create_note_state.dart';
part 'create_note_event.dart';

part 'create_note_bloc.freezed.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  CreateNoteBloc({
    required NotesRepository repository,
  })  : _repository = repository,
        super(const CreateNoteState.initial()) {
    on<CreateNoteStarted>(_onCreateNoteStarted);
  }

  final NotesRepository _repository;

  Future<void> _onCreateNoteStarted(
    CreateNoteStarted event,
    Emitter<CreateNoteState> emit,
  ) async {
    emit(const CreateNoteState.loading());
    final newNoteId = const Uuid().v4();
    final note = event.note.copyWith(id: newNoteId);
    final res = await _repository.createNote(note);
    res.fold(
      (l) => emit(CreateNoteState.failure(l.message)),
      (r) => emit(const CreateNoteState.success()),
    );
  }
}
