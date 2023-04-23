part of 'create_note_bloc.dart';

@freezed
class CreateNoteState with _$CreateNoteState {
  const factory CreateNoteState.initial() = _Initial;
  const factory CreateNoteState.loading() = _Loading;
  const factory CreateNoteState.success() = _Success;
  const factory CreateNoteState.failure(String failure) = _Failure;
}
