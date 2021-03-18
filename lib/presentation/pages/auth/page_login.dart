import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/error_messages_state_management/error_message_provider.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/presentation/bloc/bloc_firebase_user/firebase_user_bloc.dart';
import 'package:gotodo/presentation/pages/extra/page_loading_user_details_router.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool isError = false;
  String errorMessage = '';
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void signIn(BuildContext context) {
    BlocProvider.of<FirebaseUserBloc>(context).add(FirebaseSignInUserEvent(
        email: _emailController.text, password: _passwordController.text));
  }

  void showError(BuildContext context, {@required String error}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isError = true;
      });
      this.errorMessage = error;
    });
  }

  void hideError(BuildContext context) {
    BlocProvider.of<FirebaseUserBloc>(context)
        .add(FirebaseResetErrorStateEvent());
    setState(() {
      isError = false;
    });
  }

  void navigateToDetailsRouter(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
              child: UserDetailsRouterLoadingPage(),
              type: PageTransitionType.leftToRight),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: AppTheme.bezelPaddingAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Login',
                      style: AppTheme.textStyle_h3_black,
                    ),
                    BlocBuilder<FirebaseUserBloc, FirebaseUserState>(
                        builder: (context, state) {
                      if (state is FirebaseUserAwaitingState) {
                        return SpinKitCircle(
                          color: Colors.blue,
                          size: AppTheme.iconSize,
                        );
                      }

                      if (state is FirebaseUserSignedIn) {
                        Provider.of<UserProvider>(context).firebaseUser =
                            state.user;
                        navigateToDetailsRouter(context);
                        return Icon(
                          Feather.check,
                          color: Colors.green,
                          size: AppTheme.iconSize,
                        );
                      }

                      if (state is FirebaseUserErrorState) {
                        showError(context, error: state.errorMessage);
                      }

                      return Icon(
                        Icons.cached,
                        color: Colors.transparent,
                        size: AppTheme.iconSize,
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      borderRadius: AppTheme.borderRadius),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email address',
                            ),
                            controller: _emailController,
                            onChanged: (String value) {
                              hideError(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      borderRadius: AppTheme.borderRadius),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            //autofocus: true,
                            obscureText: showPassword ? false : true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                            controller: _passwordController,
                            onChanged: (String value) {
                              hideError(context);
                            },
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            showPassword ? Feather.eye : Feather.eye_off,
                            size: 18,
                          ),
                          onTap: () {
                            setState(() {
                              this.showPassword = !this.showPassword;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                isError
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    : SizedBox(),
                Container(
                  width: 120,
                  child: MainButton(
                    color: AppTheme.color_accent_1,
                    label: 'Continue',
                    labelStyle: AppTheme.textStyle_h3_white,
                    function: () {
                      signIn(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
