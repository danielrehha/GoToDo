import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'firebase_user_event.dart';
part 'firebase_user_state.dart';

class FirebaseUserBloc extends Bloc<FirebaseUserEvent, FirebaseUserState> {
  FirebaseUserBloc() : super(FirebaseUserSignedOut());

  @override
  Stream<FirebaseUserState> mapEventToState(
    FirebaseUserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
