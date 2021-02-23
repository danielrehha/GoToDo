import 'package:dartz/dartz.dart';
import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:meta/meta.dart';

abstract class ITodoItemRepository {
  Future<Either<Failure, List<TodoItemModel>>> getAllTodoItems(String userId);
  Future<Either<Failure, TodoItemModel>> createTodoItem(
      String userId, TodoItemModel todoItem);
}

class TodoItemRepository implements ITodoItemRepository {
  final IRemoteDataSource remoteDataSource;

  TodoItemRepository({@required this.remoteDataSource});

  @override
  Future<Either<Failure, TodoItemModel>> createTodoItem(
      String userId, TodoItemModel todoItem) async {
    try {
      final result = await remoteDataSource.createTodoItem(userId, todoItem);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoItemModel>>> getAllTodoItems(
      String userId) async {
    try {
      final result = await remoteDataSource.getAllTodoItems(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
