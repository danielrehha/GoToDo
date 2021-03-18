part of 'todolist_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class FetchTodoItems extends TodoEvent {
  final String userId;
  const FetchTodoItems({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class ClearTodoItemsEvent extends TodoEvent {
  @override
  List<Object> get props => [];
}
