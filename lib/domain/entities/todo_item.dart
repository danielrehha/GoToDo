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
    @required this.title,
    @required this.due,
    @required this.done,
    @required this.userId,
  });

  @override
  List<Object> get props => [id, userId, title, due, done];

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Title': title,
      'Due': due?.millisecondsSinceEpoch,
      'Done': done,
      'UserId': userId,
    };
  }
}
