part of 'firebase_user_bloc.dart';

abstract class FirebaseUserEvent extends Equatable {
  const FirebaseUserEvent();
}

class SignInUserEvent extends FirebaseUserEvent {
  final String password;
  final String email;

  SignInUserEvent(this.password, this.email);

  @override
  List<Object> get props => [password,email];
}

class SignOutUserEvent extends FirebaseUserEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}