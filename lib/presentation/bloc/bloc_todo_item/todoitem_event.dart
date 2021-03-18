part of 'todoitem_bloc.dart';

abstract class TodoItemEvent extends Equatable {
  const TodoItemEvent();
}

class CompleteTodoItemEvent extends TodoItemEvent {
  final TodoItem todoItem;
  const CompleteTodoItemEvent({@required this.todoItem});

  @override
  List<Object> get props => [id];
}

class CreateTodoItemEvent extends TodoItemEvent {
  final TodoItem todoItem;
  const CreateTodoItemEvent({@required this.todoItem});

  @override
  List<Object> get props => [id];
}

class EditTodoItemEvent extends TodoItemEvent {
  final TodoItem todoItem;

  EditTodoItemEvent(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}

class ResetAddTaskPageEvent extends TodoItemEvent {
  @override
  List<Object> get props => [];
}
