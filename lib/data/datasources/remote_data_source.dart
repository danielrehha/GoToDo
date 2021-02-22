import 'dart:convert';
import 'dart:io';

import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class IRemoteDataSource {
  Future<List<TodoItemModel>> getAllTodoItems(String userId);
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem);
}

class ApiService implements IRemoteDataSource {
  String baseUrl = 'https://localhost:5002/';

  @override
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem) async {
    //await http
  }

  @override
  Future<List<TodoItemModel>> getAllTodoItems(String userId) async {
    List<TodoItemModel> todoList;
    final result = await http
        .get(baseUrl + userId, headers: {'Content-Type': 'application/json'});
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
}
