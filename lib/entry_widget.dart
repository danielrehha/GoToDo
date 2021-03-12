import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_item/todoitem_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todolist_bloc.dart';
import 'package:gotodo/presentation/pages/auth/page_login.dart';
import 'package:gotodo/presentation/pages/auth/page_signup.dart';
import 'package:gotodo/presentation/pages/auth/page_signup_details.dart';
import 'package:gotodo/presentation/pages/home/page_home_revision.dart';

import 'presentation/pages/home/page_home_deprecated.dart';
import 'presentation/pages/auth/page_auth.dart';

class EntryWidget extends StatelessWidget {
  final ITodoItemRepository todoItemRepository;
  const EntryWidget({Key key, @required this.todoItemRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(
            repository: TodoItemRepository(
              remoteDataSource: ApiService(),
            ),
          ),
        ),
        BlocProvider<TodoItemBloc>(
          create: (context) => TodoItemBloc(
            repository: TodoItemRepository(
              remoteDataSource: ApiService(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Halifax',
        ),
        initialRoute: '/home_revision',
        routes: {
          '/auth': (context) => AuthPage(),
          '/auth/login': (context) => LoginPage(),
          '/auth/signup': (context) => SignupPage(),
          '/auth/signup/details': (context) => SignupDetails(),
          '/home': (context) => HomePageRevision(),
          '/home_revision': (context) => HomePageRevision()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
