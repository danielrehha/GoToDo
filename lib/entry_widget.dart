import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/presentation/bloc/bloc/todo_bloc.dart';

import 'presentation/pages/home_page.dart';

class EntryWidget extends StatelessWidget {
  final ITodoItemRepository todoItemRepository;
  const EntryWidget({Key key, @required this.todoItemRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository: todoItemRepository),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
