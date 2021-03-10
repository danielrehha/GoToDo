import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todo_bloc.dart';
import 'package:gotodo/presentation/pages/auth/page_login.dart';
import 'package:gotodo/presentation/pages/auth/page_signup.dart';
import 'package:gotodo/presentation/pages/auth/page_signup_details.dart';
import 'package:gotodo/presentation/pages/home/page_home_revision.dart';

import 'presentation/pages/home/page_home.dart';
import 'presentation/pages/auth/page_auth.dart';

class EntryWidget extends StatelessWidget {
  final ITodoItemRepository todoItemRepository;
  const EntryWidget({Key key, @required this.todoItemRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository: todoItemRepository),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Halifax',
        ),
        initialRoute: '/home_revision',
        routes: {
          '/': (context) => HomePage(),
          '/auth': (context) => AuthPage(),
          '/auth/login': (context) => LoginPage(),
          '/auth/signup': (context) => SignupPage(),
          '/auth/signup/details': (context) => SignupDetails(),
          '/home': (context) => HomePage(),
          '/home_revision': (context) => HomePageRevision()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
