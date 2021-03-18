part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserEvent extends UserEvent {
  final String userId;

  FetchUserEvent(this.userId);
}

class CreateUserEvent extends UserEvent {
  final String userId;
  final String username;

  CreateUserEvent({@required this.userId, @required this.username});
}

class SignOutUserEvent extends UserEvent {}
