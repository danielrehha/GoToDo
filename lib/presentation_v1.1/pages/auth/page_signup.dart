import 'package:flutter/material.dart';
import 'package:gotodo/presentation/theme/custom_theme.dart';
import 'package:gotodo/presentation_v1.1/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation_v1.1/widgets/widget_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: CustomTheme.bezelPaddingAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                      'Registration',
                      style: AppTheme.textStyle_h3_black,
                    ),
                    Icon(
                      Icons.info,
                      color: Colors.transparent,
                    )
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
                            style: AppTheme.textStyle_body_black,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          size: 18,
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
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm email address',
                            ),
                            style: AppTheme.textStyle_body_black,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          size: 18,
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                            style: AppTheme.textStyle_body_black,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: 120,
                  child: MainButton(
                    color: AppTheme.color_accent_5,
                    label: 'Continue',
                    labelStyle: AppTheme.textStyle_h3_black,
                    function: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/auth/signup/details');
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
