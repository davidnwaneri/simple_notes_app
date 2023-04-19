import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/models/models.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureEitherUser = FutureEither<User>;

typedef FutureNullableUser = Future<Option<User>>;

typedef FutureEitherUserSession = FutureEither<UserSession>;

typedef FutureEitherNotes = FutureEither<List<Note>>;

typedef FutureEitherVoid = FutureEither<Unit>;

typedef FutureVoid = Future<void>;
