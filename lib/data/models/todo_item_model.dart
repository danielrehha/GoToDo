import 'dart:convert';

import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:meta/meta.dart';

// ignore: must_be_immutable
class TodoItemModel extends TodoItem {
  TodoItemModel({
    @required int id,
    @required String userId,
    @required String title,
    @required DateTime due,
    @required bool done,
  }) : super(id: id, userId: userId, title: title, due: due, done: done);

  TodoItemModel.fromJson({@required Map<String, dynamic> json}) {
    this.title = json['title'];
    this.due = DateTime.parse(json['due']);
    this.done = json['done'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'due': this.due.toString(),
      'done': this.done,
    };
  }
}
