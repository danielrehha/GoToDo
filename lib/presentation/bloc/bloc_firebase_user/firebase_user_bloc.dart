import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/domain/repositories/firebase_user_repository.dart';
import 'package:meta/meta.dart';

part 'firebase_user_event.dart';
part 'firebase_user_state.dart';

class FirebaseUserBloc extends Bloc<FirebaseUserEvent, FirebaseUserState> {
  FirebaseUserBloc({@required this.firebaseUserRepository})
      : super(FirebaseUserInitialState());

  final IFirebaseUserRepository firebaseUserRepository;

  @override
  Stream<FirebaseUserState> mapEventToState(
    FirebaseUserEvent event,
  ) async* {
    yield FirebaseUserAwaitingState();
    if (event is FirebaseSignInUserEvent) {
      final result = await firebaseUserRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      result.fold((l) => l.errorMessage, (r) => r);
      if (result.isRight()) {
        yield FirebaseUserSignedIn(result.getOrElse(() => null));
      } else if (result.isLeft()) {
        String message;
        result.fold((l) => {message = l.errorMessage}, (r) => {});
        yield FirebaseUserErrorState(message);
      }
    }
    if (event is FirebaseCreateUserEvent) {
      final result =
          await firebaseUserRepository.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      //result.fold((l) => l.errorMessage, (r) => r);
      if (result.isRight()) {
        yield FirebaseUserSignedIn(result.getOrElse(() => null));
      } else {
        String message;
        result.fold((l) => {message = l.errorMessage}, (r) => {});
        yield FirebaseUserErrorState(message);
      }
    }
    if (event is FirebaseSignOutUserEvent) {
      final result = await firebaseUserRepository.signOut();
      if (result.isRight()) {
        yield FirebaseUserSignedOut();
        print('signed out [bloc]');
      } else {
        String message;
        result.fold((l) => {message = l.errorMessage}, (r) => {});
        yield FirebaseUserErrorState(message);
      }
    }
    if (event is FirebaseResetErrorStateEvent) {
      yield FirebaseUserInitialState();
    }
  }
}
