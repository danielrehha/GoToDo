import 'dart:convert';

import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/data/models/todo_item_model.dart';

import 'package:http/http.dart' as http;

abstract class IRemoteDataSource {
  //Todo controller endpoints
  Future<List<TodoItemModel>> getAllTodoItems(String userId);
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem);
  Future<TodoItemModel> deleteTodoItem(int id);

  //TODO: User controller endpoints
}

class ApiService implements IRemoteDataSource {
  String baseUrl = 'https://localhost:5001/';

  @override
  Future<TodoItemModel> createTodoItem(
      String userId, TodoItemModel todoItem) async {
    TodoItemModel newTodoItem;
    final jsonPostBody = jsonEncode(todoItem.toMap());
    print(jsonPostBody);
    final result = await http.post(baseUrl + 'todo/$userId/create',
        body: jsonPostBody, headers: {'Content-Type': 'application/json'});
    print(result.statusCode);
    print(result.body);
    if (result.statusCode == 200) {
      final jsonBody = jsonDecode(result.body);
      newTodoItem = TodoItemModel.fromJson(json: jsonBody);
      return newTodoItem;
    } else {
      throw new ServerException();
    }
  }

  @override
  Future<List<TodoItemModel>> getAllTodoItems(String userId) async {
    List<TodoItemModel> todoList;
    final result = await http.get(baseUrl + 'todo/$userId/all',
        headers: {'Content-Type': 'application/json'});
    if (result.statusCode == 200) {
      final jsonBody = jsonDecode(result.body);
      todoList = (jsonBody as List)
          .map((e) => TodoItemModel.fromJson(json: e))
          .toList();
      return todoList;
    } else {
      throw new ServerException();
    }
  }

  @override
  Future<TodoItemModel> deleteTodoItem(int id) async {
    TodoItemModel todoItem;
    final result = await http.get(baseUrl + 'todo/$id/delete');
    if (result.statusCode == 200) {
      final jsonBody = jsonDecode(result.body);
      todoItem = TodoItemModel.fromJson(json: jsonBody);
      return todoItem;
    } else {
      throw new ServerException();
    }
  }

  //TODO: Create user

  //TODO: Get user
}
