part of 'firebase_user_bloc.dart';

abstract class FirebaseUserState extends Equatable {
  const FirebaseUserState();
}

class FirebaseUserInitialState extends FirebaseUserState {
  @override
  List<Object> get props => [];
}

class FirebaseUserSignedOut extends FirebaseUserState {
  @override
  List<Object> get props => [];
}

class FirebaseUserSignedIn extends FirebaseUserState {
  final User user;

  FirebaseUserSignedIn(this.user);

  @override
  List<Object> get props => [user];
}

class FirebaseUserAwaitingState extends FirebaseUserState {
  @override
  List<Object> get props => [];
}

class FirebaseUserErrorState extends FirebaseUserState {
  final String errorMessage;

  FirebaseUserErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
