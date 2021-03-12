import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class IFirebaseUserAuthSource {
  Future<User> signInWithEmailAndPassword(
      {@required String email, @required String passowrd});
  Future<void> signOut();
}

class FirebaseUserAuthSource implements IFirebaseUserAuthSource {
  
  @override
  Future<User> signInWithEmailAndPassword({String email, String passowrd}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
