import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_todo_list/todolist_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_user/user_bloc.dart';
import 'package:gotodo/presentation/pages/auth/page_auth.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  void signOut(BuildContext context) {
    BlocProvider.of<FirebaseUserBloc>(context).add(FirebaseSignOutUserEvent());
  }

  void navigateToAuthPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<UserBloc>(context).add(SignOutUserEvent());
      BlocProvider.of<TodoBloc>(context).add(ClearTodoItemsEvent());
      Provider.of<UserProvider>(context, listen: false).firebaseUser = null;
      Provider.of<UserProvider>(context, listen: false).userModel = null;
      Navigator.push(
          context,
          PageTransition(
              child: AuthPage(), type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: AppTheme.bezelPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Icon(
                        Ionicons.ios_arrow_down,
                        size: AppTheme.iconSize,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Consumer<UserProvider>(builder: (context, user, child) {
                      return Text(
                        user.userModel.username,
                        style: AppTheme.textStyle_h3_black,
                      );
                    }),
                  ],
                ),
                Spacer(),
                BlocBuilder<FirebaseUserBloc, FirebaseUserState>(
                  builder: (context, state) {
                    print(state);
                    if (state is FirebaseUserAwaitingState) {
                      return MainButton(
                        color: AppTheme.color_accent_5,
                        function: () {},
                        label: 'Signing out...',
                        labelStyle: AppTheme.textStyle_h3_black,
                      );
                    }
                    if (state is FirebaseUserErrorState) {
                      print('error');
                    }
                    if (state is FirebaseUserSignedOut) {
                      navigateToAuthPage(context);
                    }
                    return MainButton(
                      color: AppTheme.color_accent_5,
                      function: () {
                        signOut(context);
                      },
                      label: 'Sign out',
                      labelStyle: AppTheme.textStyle_h3_black,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
