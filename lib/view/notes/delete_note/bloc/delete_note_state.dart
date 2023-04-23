part of 'delete_note_bloc.dart';

@freezed
class DeleteNoteState with _$DeleteNoteState {
  const factory DeleteNoteState.initial() = _Initial;
  const factory DeleteNoteState.inProgress() = _InProgress;
  const factory DeleteNoteState.success() = _Success;
  const factory DeleteNoteState.failure({required String message}) = _Failure;
}
