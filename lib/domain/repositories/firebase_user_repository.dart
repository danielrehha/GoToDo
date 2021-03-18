import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/data/datasources/firebase_auth_source.dart';
import 'package:meta/meta.dart';

abstract class IFirebaseUserRepository {
  Future<Either<FirebaseFailure, User>> createUserWithEmailAndPassword(
      {@required String email, @required String password});
  Future<Either<FirebaseFailure, User>> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<Either<FirebaseFailure, bool>> signOut();
}

class FirebaseUserRepository implements IFirebaseUserRepository {
  final IFirebaseUserAuthSource firebaseUserAuthSource;

  const FirebaseUserRepository({@required this.firebaseUserAuthSource});

  @override
  Future<Either<FirebaseFailure, User>> createUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final user = await firebaseUserAuthSource.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }

  @override
  Future<Either<FirebaseFailure, User>> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final result = await firebaseUserAuthSource.signInWithEmailAndPassword(
        email: email, password: password);
    try {
      await firebaseUserAuthSource.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on Exception catch (e) {
      return result;
    }
  }

  @override
  Future<Either<FirebaseFailure, bool>> signOut() async {
    try {
      await firebaseUserAuthSource.signOut();
      print('signed out [repo]');
      return Right(true);
    } on Exception catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
