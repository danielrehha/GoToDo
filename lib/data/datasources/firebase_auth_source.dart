import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:meta/meta.dart';

abstract class IFirebaseUserAuthSource {
  Future<User> createUserWithEmailAndPassword(
      {@required String email, @required String password});
  Future<Either<FirebaseFailure, User>> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> signOut();
}

class FirebaseUserAuthSource implements IFirebaseUserAuthSource {
  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<Either<FirebaseFailure, User>> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    } on PlatformException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('signed out [api]');
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }
}
