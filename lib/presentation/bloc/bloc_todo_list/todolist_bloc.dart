import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gotodo/data/models/todo_item_model.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:meta/meta.dart';

part 'todolist_event.dart';
part 'todolist_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoItemRepository repository;

  TodoBloc({@required this.repository}) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is FetchTodoItems) {
      yield TodoLoading();
      var result = await repository.getAllTodoItems(event.userId);
      if (result.isRight()) {
        yield TodoLoaded(todoItems: result.getOrElse(() => null));
      } else {
        yield TodoError();
      }
    }
    if (event is ClearTodoItemsEvent) {
      yield TodoInitial();
    }
  }
}
