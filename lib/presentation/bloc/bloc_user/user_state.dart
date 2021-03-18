part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserBlocInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserBlocLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserBlocErrorState extends UserState {
  @override
  List<Object> get props => [];
}

class UserBlocNotFoundState extends UserState {
  final String userId;

  UserBlocNotFoundState({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class UserBlocSignedInState extends UserState {
  final UserEntity user;

  const UserBlocSignedInState(this.user);

  @override
  List<Object> get props => [user];
}

class UserBlocSignedOutState extends UserState {
  @override
  List<Object> get props => [];
}
