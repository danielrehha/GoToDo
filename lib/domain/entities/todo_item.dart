import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TodoItem extends Equatable {
  int id;
  String userId;
  String title;
  DateTime due;
  bool done;

  TodoItem({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.due,
    @required this.done,
  });

  @override
  List<Object> get props => [id, userId, title, due, done];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'due': due?.millisecondsSinceEpoch,
      'done': done,
    };
  }
}
