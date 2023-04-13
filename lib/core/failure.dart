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
