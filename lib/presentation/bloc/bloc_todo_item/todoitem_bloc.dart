import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/entities/todo_item.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:meta/meta.dart';

part 'todoitem_event.dart';
part 'todoitem_state.dart';

class TodoItemBloc extends Bloc<TodoItemEvent, TodoItemState> {
  TodoItemBloc({@required this.repository}) : super(TodoItemInitial());

  final TodoItemRepository repository;

  @override
  Stream<TodoItemState> mapEventToState(
    TodoItemEvent event,
  ) async* {
    if (event is CompleteTodoItemEvent) {
      yield TodoItemCompleting(todoItem: event.todoItem);
      final result = await repository.deleteTodoItem(event.todoItem);
      if (result.isRight()) {
        print('Deleted task! [bloc]');
        yield TodoItemCompleted(todoItem: result.getOrElse(() => null));
      } else {
        print('Error deleting task! [bloc]');
        yield TodoItemCompletionError(todoItem: event.todoItem);
      }
    } else if (event is CreateTodoItemEvent) {
      yield TodoItemCreating(todoItem: event.todoItem);
      final result = await repository.createTodoItem(
          userId: 'id', todoItem: event.todoItem);
      if (result.isRight()) {
        print('Created task! [bloc]');
        yield TodoItemCreated(todoItem: result.getOrElse(() => null));
      } else {
        print('Error creating task! [bloc]');
        yield TodoItemCreationError(todoItem: event.todoItem);
      }
    } else if (event is ResetAddTaskPageEvent) {
      yield TodoItemInitial();
    } else if (event is EditTodoItemEvent) {
      yield TodoItemCreating(todoItem: event.todoItem);
      final result = await repository.editTodoItem(event.todoItem);
      if (result.isRight()) {
        print('Edited task! [bloc]');
        yield TodoItemCreated(todoItem: result.getOrElse(() => null));
      } else {
        print('Error creating task! [bloc]');
        yield TodoItemCreationError(todoItem: event.todoItem);
      }
    }
  }
}
