import 'package:dartz/dartz.dart';
import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/data/models/user_model.dart';
import 'package:meta/meta.dart';

abstract class IUserRepository {
  Future<Either<ServerFailure, UserModel>> createUser(
      {@required String userId, @required String username});
  Future<Either<ServerFailure, UserModel>> getUser({@required String userId});
}

class UserRepository implements IUserRepository {
  final IRemoteDataSource remoteDataSource;

  UserRepository({@required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, UserModel>> createUser(
      {@required String userId, @required String username}) async {
    try {
      final result =
          await remoteDataSource.createUser(userId: userId, username: username);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, UserModel>> getUser({String userId}) async {
    try {
      final result = await remoteDataSource.getUser(userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }
}
