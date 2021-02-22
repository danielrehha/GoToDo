import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/data/models/todo_item_model.dart';

abstract class ITodoItemRepository {
  Future<List<TodoItemModel>> getAllTodoItems(String userId);
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem);
  Future<TodoItemModel> getOneTodoItem(int id);
}

class TodoItemRepository implements ITodoItemRepository {
  final IRemoteDataSource remoteDataSource;

  TodoItemRepository(this.remoteDataSource);

  @override
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem) async {
    // TODO: implement createTodoItem
    throw UnimplementedError();
  }

  @override
  Future<List<TodoItemModel>> getAllTodoItems(String userId) async {
    // TODO: implement getAllTodoItems
    throw UnimplementedError();
  }

  @override
  Future<TodoItemModel> getOneTodoItem(int id) async {
    // TODO: implement getOneTodoItem
    throw UnimplementedError();
  }
}
