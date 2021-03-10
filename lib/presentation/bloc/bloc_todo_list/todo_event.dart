part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  // final String userId;
  const TodoEvent();

  // @override
  // List<Object> get props => [userId];
}

class FetchTodoItems extends TodoEvent {
  final String userId;
  const FetchTodoItems({@required this.userId});

  @override
  List<Object> get props => [userId];
}
