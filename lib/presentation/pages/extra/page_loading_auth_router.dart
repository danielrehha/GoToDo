import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/bloc/bloc_user/user_bloc.dart';
import 'package:gotodo/presentation/pages/extra/page_loading_user_details_router.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gotodo/presentation/widgets/widget_loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AuthRouterLoadingPage extends StatefulWidget {
  AuthRouterLoadingPage({Key key}) : super(key: key);

  @override
  _AuthRouterLoadingPageState createState() => _AuthRouterLoadingPageState();
}

class _AuthRouterLoadingPageState extends State<AuthRouterLoadingPage> {
  @override
  void initState() {
    super.initState();
/*     FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        firebaseSignedIn = false;
      } else {
        firebaseSignedIn = true;
        this.user = user;
        print(user.uid);
      }
      
    }); */
    registerAuthListener(context);
  }

  @override
  void displose() {
    super.dispose();
  }

  void registerAuthListener(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (FirebaseAuth.instance.currentUser != null) {
        Provider.of<UserProvider>(context, listen: false)
            .setFirebaseUser(user: FirebaseAuth.instance.currentUser);
        Navigator.push(
            context,
            PageTransition(
                child: UserDetailsRouterLoadingPage(),
                type: PageTransitionType.fade));
      } else {
        print('user is signed out');
        Navigator.pushNamedAndRemoveUntil(
            context, '/auth', ((Route<dynamic> route) => false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppTheme.color_accent_1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
