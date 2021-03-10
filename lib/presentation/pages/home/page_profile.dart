import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gotodo/presentation/pages/auth/page_auth.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

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
                    Text(
                      'Hi, Daniel!',
                      style: AppTheme.textStyle_h3_black,
                    ),
                  ],
                ),
                Spacer(),
                MainButton(
                  color: AppTheme.color_accent_5,
                  function: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/auth', ModalRoute.withName('/auth'));
                  },
                  label: 'Sign out',
                  labelStyle: AppTheme.textStyle_h3_black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
