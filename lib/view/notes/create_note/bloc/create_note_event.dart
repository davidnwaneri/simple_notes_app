part of 'create_note_bloc.dart';

abstract class CreateNoteEvent extends Equatable {
  const CreateNoteEvent();

  @override
  List<Object> get props => [];
}

class CreateNoteStarted extends CreateNoteEvent {
  const CreateNoteStarted({
    required this.note,
  });

  final Note note;

  @override
  List<Object> get props => [note];
}
