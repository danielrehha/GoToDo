import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/pages/extra/page_error.dart';
import 'package:gotodo/presentation/pages/extra/page_loading_auth_router.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gotodo/presentation/widgets/widget_loading_indicator.dart';

class InitializerLoadingPage extends StatefulWidget {
  InitializerLoadingPage({Key key}) : super(key: key);

  @override
  _InitializerLoadingPageState createState() => _InitializerLoadingPageState();
}

class _InitializerLoadingPageState extends State<InitializerLoadingPage> {
  bool signedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: AppTheme.color_accent_1),
          child: Center(
            child: FutureBuilder(
              // Initialize FlutterFire
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return ErrorPage();
                }

                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return AuthRouterLoadingPage();
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return LoadingIndicator();
              },
            ),
          )),
    );
  }
}
