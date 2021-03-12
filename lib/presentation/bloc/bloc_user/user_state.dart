part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoggedIn extends UserState {
  final UserEntity user;

  const UserLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class SignedOut extends UserState {
  @override
  List<Object> get props => [];
}
