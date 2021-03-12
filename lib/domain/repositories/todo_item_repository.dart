import 'package:dartz/dartz.dart';
import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:meta/meta.dart';

abstract class ITodoItemRepository {
  Future<Either<Failure, List<TodoItemModel>>> getAllTodoItems(String userId);
  Future<Either<Failure, TodoItemModel>> createTodoItem(
      {@required String userId, @required TodoItemModel todoItem});
  Future<Either<Failure, TodoItemModel>> deleteTodoItem(TodoItem todoItem);
}

class TodoItemRepository implements ITodoItemRepository {
  final IRemoteDataSource remoteDataSource;

  TodoItemRepository({@required this.remoteDataSource});

  @override
  Future<Either<Failure, TodoItemModel>> createTodoItem(
      {@required String userId, @required TodoItemModel todoItem}) async {
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

  @override
  Future<Either<Failure, TodoItemModel>> deleteTodoItem(
      TodoItem todoItem) async {
    try {
      final result = await remoteDataSource.deleteTodoItem(todoItem.id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
