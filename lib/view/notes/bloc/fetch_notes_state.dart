part of 'fetch_notes_bloc.dart';

@freezed
class FetchNotesState with _$FetchNotesState {
  const factory FetchNotesState.initial() = _Initial;

  const factory FetchNotesState.loading() = _Loading;

  const factory FetchNotesState.loaded({required List<Note> notes}) = _Loaded;

  const factory FetchNotesState.error(String error) = _Error;
}
