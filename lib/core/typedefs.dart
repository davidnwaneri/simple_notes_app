import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/models/models.dart';

typedef FutureEitherNotes = Future<Either<Failure, List<Note>>>;
typedef FutureEitherVoid = Future<Either<Failure, Unit>>;
