import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/core/providers/user_provider/user_provider.dart';
import 'package:gotodo/presentation/bloc/bloc_user/user_bloc.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:provider/provider.dart';

class SignupDetails extends StatefulWidget {
  SignupDetails({Key key}) : super(key: key);

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  int pageIndex = 0;

  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  void navigateToHomePage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    });
  }

  void createUser(BuildContext context) {
    final userId =
        Provider.of<UserProvider>(context, listen: false).firebaseUser.uid;
    BlocProvider.of<UserBloc>(context)
        .add(CreateUserEvent(userId: userId, username: _nameController.text));
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Text(
                  'How may we call you?',
                  style: AppTheme.textStyle_h2_black,
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    Text(
                      'My name is',
                      style: AppTheme.textStyle_h1_black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 36,
                          color: AppTheme.color_accent_2,
                          fontWeight: FontWeight.w600,
                        ),
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: _nameController,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.architecture,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: (pageIndex == 0)
                            ? Colors.transparent
                            : Colors.black,
                        size: 32,
                      ),
                      onTap: () {
                        goLeft();
                      },
                    ),
/*                     AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: dotPageMark()), */
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserBlocSignedInState) {
                          Provider.of<UserProvider>(context, listen: false)
                              .setUserModel(user: state.user);
                          navigateToHomePage(context);
                        }
                        if (state is UserBlocErrorState) {}
                        if (state is UserBlocLoadingState) {
                          return SpinKitCircle(
                              size: 20, color: AppTheme.color_accent_3);
                        }
                        return InkWell(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 32,
                          ),
                          onTap: () {
                            createUser(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goRight() {
    if (pageIndex < 2) {
      setState(() {
        pageIndex++;
      });
    }
  }

  void goLeft() {
    if (pageIndex > 0) {
      setState(() {
        pageIndex--;
      });
    }
  }

  Widget dotPageMark() {
    var _spacing = 10.0;
    var _smallSize = 8.0;
    var _currentSize = 12.0;
    Color _currentColor = AppTheme.color_accent_3;
    Color _secondaryColor = Colors.grey;
    switch (pageIndex) {
      case 0:
        return Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: _currentColor,
              size: _currentSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
          ],
        );
        break;
      case 1:
        return Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _currentColor,
              size: _currentSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
          ],
        );
        break;
      case 2:
        return Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _secondaryColor,
              size: _smallSize,
            ),
            SizedBox(
              width: _spacing,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: _currentColor,
              size: _currentSize,
            ),
          ],
        );
        break;
    }
  }
}
