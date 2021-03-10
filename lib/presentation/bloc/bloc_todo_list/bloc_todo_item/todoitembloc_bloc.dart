import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todoitembloc_event.dart';
part 'todoitembloc_state.dart';

class TodoitemblocBloc extends Bloc<TodoitemblocEvent, TodoitemblocState> {
  TodoitemblocBloc() : super(TodoitemblocInitial());

  @override
  Stream<TodoitemblocState> mapEventToState(
    TodoitemblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
