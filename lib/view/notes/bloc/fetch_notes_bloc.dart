import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/service.dart';

part 'fetch_notes_bloc.freezed.dart';
part 'fetch_notes_event.dart';
part 'fetch_notes_state.dart';

class FetchNotesBloc extends Bloc<FetchNotesEvent, FetchNotesState> {
  FetchNotesBloc({
    required INoteService noteService,
  })  : _noteService = noteService,
        super(const _Initial()) {
    on<NotesFetched>(_onNotesFetched);
    add(const NotesFetched());
  }

  final INoteService _noteService;

  Future<void> _onNotesFetched(
    NotesFetched event,
    Emitter<FetchNotesState> emit,
  ) async {
    emit(const _Loading());
    final res = await _noteService.fetchNotes();
    res.fold(
      (l) => emit(_Error(l.message)),
      (notes) => emit(_Loaded(notes: notes)),
    );
  }
}
