import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/data/models/user_model.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_user/user_bloc.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gotodo/presentation/widgets/widget_loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UserDetailsRouterLoadingPage extends StatefulWidget {
  UserDetailsRouterLoadingPage({Key key}) : super(key: key);

  @override
  _UserDetailsRouterLoadingPageState createState() =>
      _UserDetailsRouterLoadingPageState();
}

class _UserDetailsRouterLoadingPageState
    extends State<UserDetailsRouterLoadingPage> {
  void navigateToDetailsPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/auth/signup/details', (route) => false);
    });
  }

  void navigateToHomePage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    });
  }

  void setUserInProvider(BuildContext context, {@required UserModel user}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).userModel = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context).firebaseUser.uid;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserBlocInitialState) {
                  BlocProvider.of<UserBloc>(context)
                      .add(FetchUserEvent(userId));
                }
                if (state is UserBlocLoadingState) {}
                if (state is UserBlocSignedInState) {
                  navigateToHomePage(context);
                  setUserInProvider(context, user: state.user);
                }
                if (state is UserBlocSignedOutState) {}
                if (state is UserBlocNotFoundState) {
                  navigateToDetailsPage(context);
                }
                return LoadingIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
