import 'package:flutter/material.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          /* image: DecorationImage(
            image: AssetImage('bg_ambient_1.jpeg'),
            fit: BoxFit.cover,
          ), */
        ),
        child: SafeArea(
          child: Padding(
            padding: AppTheme.bezelPaddingAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(),
                Column(children: [
                  Text(
                    'GoToDo!',
                    style: AppTheme.textStyle_h1_black,
                    textAlign: TextAlign.center,
                  ),
/*                   Container(
                    width: 124,
                    height: 124,
                    child: Image(
                      image: AssetImage('logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ), */
                  Text(
                    'Organize your day',
                    style: AppTheme.textStyle_h3_black,
                    textAlign: TextAlign.center,
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MainButton(
                          color: AppTheme.color_accent_1,
                          function: () {
                            Navigator.of(context).pushNamed('/auth/login');
                          },
                          label: 'Login',
                          labelStyle: AppTheme.textStyle_h3_white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MainButton(
                          color: AppTheme.color_accent_5,
                          function: () {
                            Navigator.of(context).pushNamed('/auth/signup');
                          },
                          label: 'Sign up',
                          labelStyle: AppTheme.textStyle_h3_black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
/*                     boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black12,
                          offset: Offset(0, 1))
                    ], */
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle:
                TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
