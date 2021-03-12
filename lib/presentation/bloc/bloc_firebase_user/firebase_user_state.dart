part of 'firebase_user_bloc.dart';

abstract class FirebaseUserState extends Equatable {
  const FirebaseUserState();
}

class FirebaseUserSignedOut extends FirebaseUserState {

  @override
  List<Object> get props => [];
}

class FirebaseUserSignedIn extends FirebaseUserState {
  final User firebaseUser;

  FirebaseUserSignedIn(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];
}
