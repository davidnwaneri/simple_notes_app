part of 'fetch_notes_bloc.dart';

abstract class FetchNotesEvent extends Equatable {
  const FetchNotesEvent();

  @override
  List<Object> get props => [];
}

class NotesFetched extends FetchNotesEvent {
  const NotesFetched();
}
