// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/repository/repository.dart';

part 'delete_note_state.dart';
part 'delete_note_event.dart';

part 'delete_note_bloc.freezed.dart';

class DeleteNoteBloc extends Bloc<DeleteNoteEvent, DeleteNoteState> {
  DeleteNoteBloc({
    required IDeleteNoteRepository repository,
  })  : _repository = repository,
        super(const DeleteNoteState.initial()) {
    on<DeleteNoteStarted>(_onDeleteNoteStarted);
  }

  final IDeleteNoteRepository _repository;

  Future<void> _onDeleteNoteStarted(
    DeleteNoteStarted event,
    Emitter<DeleteNoteState> emit,
  ) async {
    emit(const DeleteNoteState.inProgress());
    final res = await _repository.deleteNote(event.note);
    res.fold(
      (l) => emit(DeleteNoteState.failure(message: l.message)),
      (r) => emit(const DeleteNoteState.success()),
    );
  }
}
