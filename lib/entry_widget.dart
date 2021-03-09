import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:gotodo/presentation_v1.1/pages/auth/page_login.dart';
import 'package:gotodo/presentation_v1.1/pages/auth/page_signup.dart';
import 'package:gotodo/presentation_v1.1/pages/auth/page_signup_details.dart';

import 'presentation_v1.1/pages/home/page_home.dart';
import 'presentation_v1.1/pages/auth/page_auth.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/auth': (context) => AuthPage(),
          '/auth/login': (context) => LoginPage(),
          '/auth/signup': (context) => SignupPage(),
          '/auth/signup/details': (context) => SignupDetails(),
          '/home': (context) => HomePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
