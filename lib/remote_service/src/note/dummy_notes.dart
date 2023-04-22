// 🎯 Dart imports:
import 'dart:collection';

// 🌎 Project imports:
import 'package:simple_notes_app/models/models.dart';

UnmodifiableListView<Note> get dummyNotes {
  return UnmodifiableListView(_dummyNotes);
}

const _dummyNotes = <Note>[
  Note(
    id: '1',
    title: 'The Inception',
    body: 'The Inception is a 2010 science fiction action film written, '
        'produced, and directed by Christopher Nolan, and co-produced by '
        'Emma Thomas. The film stars Leonardo DiCaprio as a professional thief '
        'who steals information by infiltrating the subconscious, and is '
        'offered a chance to have his criminal history erased as payment '
        "for the implantation of another person's idea "
        "into a target's subconscious.",
    lastModified: '2021-08-01',
  ),
  Note(
    id: '2',
    title: 'The Dark Knight',
    body: 'The Dark Knight is a 2008 superhero film directed, '
        'produced, and co-written by Christopher Nolan. '
        'Based on the DC Comics character Batman, '
        "the film is the second part of Nolan's "
        "The Dark Knight Trilogy and a sequel to 2005's Batman Begins, "
        'starring an ensemble cast including Christian Bale, '
        'Heath Ledger, Aaron Eckhart, Michael Caine, '
        'Maggie Gyllenhaal, Gary Oldman, and Morgan Freeman. '
        'In the film, Batman and Lieutenant James Gordon '
        'join forces to investigate the mysterious '
        'deaths of several mob bosses, while the '
        'corrupt businessman '
        'Lloyd Dent plots to take over Gotham City.',
    lastModified: '2021-08-01',
  ),
  Note(
    id: '3',
    body: 'Lorem ipsum Lorem ipsum',
    lastModified: '2021-08-01',
  ),
];
