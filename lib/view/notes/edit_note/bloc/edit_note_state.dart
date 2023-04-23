part of 'edit_note_bloc.dart';

@freezed
class EditNoteState with _$EditNoteState{
  const factory EditNoteState.initial() = _Initial;
  const factory EditNoteState.inProgress() = _InProgress;
  const factory EditNoteState.success() = _Success;
  const factory EditNoteState.failure({required String message}) = _Failure;
}
