import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gotodo/domain/entities/user.dart';
import 'package:gotodo/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({@required this.repository}) : super(UserBlocInitialState());

  final IUserRepository repository;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserBlocLoadingState();
    if (event is FetchUserEvent) {
      final result = await repository.getUser(userId: event.userId);
      if (result.isRight()) {
        yield UserBlocSignedInState(result.getOrElse(() => null));
      } else {
        yield UserBlocNotFoundState(userId: event.userId);
      }
    }
    if (event is CreateUserEvent) {
      final result = await repository.createUser(
          userId: event.userId, username: event.username);
      if (result.isRight()) {
        yield UserBlocSignedInState(result.getOrElse(() => null));
      } else {
        yield UserBlocErrorState();
      }
    }
    if (event is SignOutUserEvent) {
      yield UserBlocInitialState();
    }
  }
}
