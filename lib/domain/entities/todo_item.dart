import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TodoItem extends Equatable {
  String title;
  DateTime due;
  bool done;

  TodoItem({
    @required this.title,
    @required this.due,
    @required this.done,
  });

  @override
  List<Object> get props => [title, due, done];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'due': due?.millisecondsSinceEpoch,
      'done': done,
    };
  }
}
