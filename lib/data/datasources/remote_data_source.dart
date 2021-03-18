import 'dart:convert';

import 'package:gotodo/core/exceptions/exceptions.dart';
import 'package:gotodo/data/datasources/temp_data.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/data/models/user_model.dart';
import 'package:gotodo/domain/entities/user.dart';
import 'package:gotodo/fixtures/fixture.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class IRemoteDataSource {
  //Todo controller endpoints
  Future<List<TodoItemModel>> getAllTodoItems(String userId);
  Future<TodoItemModel> createTodoItem(String userId, TodoItemModel todoItem);
  Future<TodoItemModel> deleteTodoItem(int id);
  Future<TodoItemModel> editTodoItem({@required TodoItemModel todoItem});

  //User controller endpoints
  Future<UserEntity> createUser(
      {@required String userId, @required String username});
  Future<UserEntity> getUser({@required String userId});
}

class ApiService implements IRemoteDataSource {
  final String baseUrl = 'https://localhost:5001/';
  String apiKey = APIKEY;

  Map<String, String> _header = Map<String, String>();

  void loadApiKey() async {
    final result = jsonDecode(await fixture('cache.json'));
    apiKey = result['ApiKey'];
    print('Loaded ApiKey: $apiKey');
  }

  ApiService() {
    //loadApiKey();
    _header = {
      'Content-Type': 'application/json',
      'ApiKey': apiKey,
    };
  }

  @override
  Future<TodoItemModel> createTodoItem(
      String userId, TodoItemModel todoItem) async {
    TodoItemModel newTodoItem;
    final jsonPostBody = jsonEncode(todoItem.toMap());
    print(jsonPostBody);
    final result = await http.post(baseUrl + 'todo/$userId/create',
        body: jsonPostBody, headers: _header);
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
    final result =
        await http.get(baseUrl + 'todo/$userId/all', headers: _header);
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
    final result =
        await http.get(baseUrl + 'todo/$id/delete', headers: _header);
    if (result.statusCode == 200) {
      final jsonBody = jsonDecode(result.body);
      todoItem = TodoItemModel.fromJson(json: jsonBody);
      return todoItem;
    } else {
      throw new ServerException();
    }
  }

  @override
  Future<UserEntity> createUser(
      {@required String userId, @required String username}) async {
    UserModel receivedUser;
    final result = await http.post(baseUrl + 'user/create/$userId/$username',
        headers: _header);
    if (result.statusCode == 200) {
      final jsonResult = jsonDecode(result.body);
      receivedUser = UserModel.fromJson(jsonResult);
      return receivedUser;
    } else {
      throw new ServerException();
    }
  }

  @override
  Future<UserEntity> getUser({@required String userId}) async {
    final result = await http.get(baseUrl + 'user/$userId', headers: _header);
    if (result.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(result.body));
    } else {
      throw new ServerException();
    }
  }

  @override
  Future<TodoItemModel> editTodoItem({TodoItemModel todoItem}) async {
    final jsonBody = jsonEncode(todoItem.toMap());
    final result = await http.post(baseUrl + 'todo/${todoItem.id}/edit',
        body: jsonBody, headers: _header);
    if (result.statusCode == 200) {
      final jsonResult = jsonDecode(result.body);
      final todoItemResult = TodoItemModel.fromJson(json: jsonResult);
      return todoItemResult;
    } else {
      throw new ServerException();
    }
  }
}
