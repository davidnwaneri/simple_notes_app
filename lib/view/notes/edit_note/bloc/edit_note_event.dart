part of 'edit_note_bloc.dart';

abstract class EditNoteEvent extends Equatable {
  const EditNoteEvent();

  @override
  List<Object> get props => [];
}

class EditNoteStarted extends EditNoteEvent {
  const EditNoteStarted({
    required this.note,
  });

  final Note note;

  @override
  List<Object> get props => [note];
}

