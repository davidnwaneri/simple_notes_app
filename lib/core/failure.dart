abstract class Failure implements Exception {
  Failure(
    this.message, {
    this.stackTrace,
  });

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return '$runtimeType: Message => $message, StackTrace => $stackTrace';
  }
}

class FetchingNotesFailure extends Failure {
  FetchingNotesFailure(super.message, {super.stackTrace});
}

class SignUpFailure extends Failure {
  SignUpFailure(super.message, {super.stackTrace});
}

class SignInFailure extends Failure {
  SignInFailure(super.message, {super.stackTrace});
}

class SignOutFailure extends Failure {
  SignOutFailure(super.message, {super.stackTrace});
}

class SaveDataFailure extends Failure {
  SaveDataFailure(super.message, {super.stackTrace});
}

class ReadDataFailure extends Failure {
  ReadDataFailure(super.message, {super.stackTrace});
}

class DeleteDataFailure extends Failure {
  DeleteDataFailure(super.message, {super.stackTrace});
}

class CreateNoteFailure extends Failure {
  CreateNoteFailure(super.message, {super.stackTrace});
}

class EditNoteFailure extends Failure {
  EditNoteFailure(super.message, {super.stackTrace});
}

class DeleteNoteFailure extends Failure {
  DeleteNoteFailure(super.message, {super.stackTrace});
}
