part of 'todolist_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoItemModel> todoItems;

  const TodoLoaded({
    @required this.todoItems,
  });

  @override
  List<Object> get props => [todoItems];
}

class TodoError extends TodoState {}
