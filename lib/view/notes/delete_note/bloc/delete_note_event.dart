part of 'delete_note_bloc.dart';

abstract class DeleteNoteEvent extends Equatable {
  const DeleteNoteEvent();

  @override
  List<Object> get props => [];
}

class DeleteNoteStarted extends DeleteNoteEvent {
  const DeleteNoteStarted({
    required this.note,
  });

  final Note note;

  @override
  List<Object> get props => [note];
}
