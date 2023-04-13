import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/models/models.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureEitherUser = FutureEither<User>;

typedef FutureEitherNotes = FutureEither<List<Note>>;

typedef FutureEitherVoid = FutureEither<Unit>;
