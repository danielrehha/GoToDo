import 'package:flutter/material.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';
import 'package:gotodo/presentation/widgets/widget_button.dart';

class SignupDetails extends StatefulWidget {
  SignupDetails({Key key}) : super(key: key);

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  int pageIndex = 0;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: dotPageMark()),
                    InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 32,
                      ),
                      onTap: () {
                        goRight();
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
