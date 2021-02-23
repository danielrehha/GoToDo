import 'package:dartz/dartz.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/core/use_case.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:meta/meta.dart';

class GetAllTodoItems implements UseCase {
  final ITodoItemRepository todoItemRepository;

  GetAllTodoItems(this.todoItemRepository);

  @override
  Future<Either<Failure, List<TodoItemModel>>> call(
      {@required String userId}) async {
    return await todoItemRepository.getAllTodoItems(userId);
  }
}
