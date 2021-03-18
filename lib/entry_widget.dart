import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotodo/core/providers/error_messages_state_management/error_message_provider.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/data/datasources/firebase_auth_source.dart';
import 'package:gotodo/data/datasources/remote_data_source.dart';
import 'package:gotodo/domain/repositories/firebase_user_repository.dart';
import 'package:gotodo/domain/repositories/todo_item_repository.dart';
import 'package:gotodo/domain/repositories/user_repository.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_item/todoitem_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todolist_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_user/user_bloc.dart';
import 'package:gotodo/presentation/pages/auth/page_login.dart';
import 'package:gotodo/presentation/pages/auth/page_signup.dart';
import 'package:gotodo/presentation/pages/auth/page_signup_details.dart';
import 'package:gotodo/presentation/pages/extra/page_error.dart';
import 'package:gotodo/presentation/pages/extra/page_loading_auth_router.dart';
import 'package:gotodo/presentation/pages/extra/page_loading_initializer.dart';
import 'package:gotodo/presentation/pages/home/page_home_revision.dart';
import 'presentation/pages/auth/page_auth.dart';
import 'package:provider/provider.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ErrorMessageProvider>(
            create: (_) => ErrorMessageProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider())
      ],
      child: MultiBlocProvider(
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
          BlocProvider<FirebaseUserBloc>(
            create: (context) => FirebaseUserBloc(
              firebaseUserRepository: FirebaseUserRepository(
                firebaseUserAuthSource: FirebaseUserAuthSource(),
              ),
            ),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              repository: UserRepository(
                remoteDataSource: ApiService(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Halifax',
          ),
          initialRoute: '/initializer',
          routes: {
            '/initializer': (context) => InitializerLoadingPage(),
            '/router': (context) => AuthRouterLoadingPage(),
            '/auth': (context) => AuthPage(),
            '/auth/login': (context) => LoginPage(),
            '/auth/signup': (context) => SignupPage(),
            '/auth/signup/details': (context) => SignupDetails(),
            '/home': (context) => HomePageRevision(),
            '/error': (context) => ErrorPage(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
