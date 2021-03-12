part of 'todoitem_bloc.dart';

abstract class TodoItemState extends Equatable {
  final TodoItem todoItem;
  const TodoItemState(this.todoItem);

  @override
  List<Object> get props => [];
}

class TodoItemInitial extends TodoItemState {
  TodoItemInitial({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCompleting extends TodoItemState {
  TodoItemCompleting({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCompletionError extends TodoItemState {
  TodoItemCompletionError({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCreating extends TodoItemState {
  TodoItemCreating({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCreationError extends TodoItemState {
  TodoItemCreationError({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCreated extends TodoItemState {
  TodoItemCreated({@required TodoItem todoItem}) : super(todoItem);
}

class TodoItemCompleted extends TodoItemState {
  final TodoItemModel todoItem;

  TodoItemCompleted({
    @required this.todoItem,
  }) : super(todoItem);
}
