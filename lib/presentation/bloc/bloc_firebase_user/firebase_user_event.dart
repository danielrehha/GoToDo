part of 'firebase_user_bloc.dart';

abstract class FirebaseUserEvent extends Equatable {
  const FirebaseUserEvent();
}

class FirebaseResetErrorStateEvent extends FirebaseUserEvent {
  @override
  List<Object> get props => [];
}

class FirebaseSignInUserEvent extends FirebaseUserEvent {
  final String email;
  final String password;

  FirebaseSignInUserEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class FirebaseCreateUserEvent extends FirebaseUserEvent {
  final String password;
  final String email;

  FirebaseCreateUserEvent(this.password, this.email);

  @override
  List<Object> get props => [password, email];
}

class FirebaseSignOutUserEvent extends FirebaseUserEvent {
  @override
  List<Object> get props => [];
}
