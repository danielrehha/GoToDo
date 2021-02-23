import 'package:dartz/dartz.dart';
import 'package:gotodo/core/failures/failures.dart';
import 'package:gotodo/core/use_case.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:meta/meta.dart';

class CreateTodoItem implements UseCase {
  final ITodoItemRepository todoItemRepository;

  CreateTodoItem(this.todoItemRepository);
  @override
  Future<Either<Failure, TodoItemModel>> call({
    @required String userId,
    @required TodoItemModel todoItem,
  }) async {
    return await todoItemRepository.createTodoItem(userId, todoItem);
  }
}
