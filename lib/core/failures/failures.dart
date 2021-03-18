abstract class Failure {}

class ServerFailure implements Failure {}

class FirebaseFailure implements Failure {
  final String errorMessage;

  FirebaseFailure(this.errorMessage) {
    print(errorMessage);
  }
}
