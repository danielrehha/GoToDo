import 'dart:convert';

import 'data/models/todo_item_model.dart';
import 'fixtures/fixture.dart';

class DevelopmentCache {
  static Future<List<TodoItemModel>> todoItems() async {
    final string = await fixture('todos.json');
    final cache = jsonDecode(string);
    List<TodoItemModel> result =
        (cache as List).map((e) => TodoItemModel.fromJson(json: e)).toList();
    return result;
  }
}
