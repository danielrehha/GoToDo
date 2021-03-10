import 'package:flutter/material.dart';

class AppTheme {
  // TextStyles
  static const double _letterSpacing = -0.5;
  static const double _headerLetterSpacing = -0.5;
  static const TextStyle textStyle_h1_black = TextStyle(
    fontSize: 36,
    color: Colors.black87,
    fontWeight: FontWeight.w700,
    letterSpacing: _headerLetterSpacing,
  );
  static const TextStyle textStyle_h2_black = TextStyle(
    fontSize: 24,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    letterSpacing: _letterSpacing,
  );
  static const TextStyle textStyle_h3_black = TextStyle(
    fontSize: 18,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    letterSpacing: _letterSpacing,
  );
  static const TextStyle textStyle_h1_white = TextStyle(
    fontSize: 34,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: _headerLetterSpacing,
  );
  static const TextStyle textStyle_h2_white = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: _letterSpacing,
  );
  static const TextStyle textStyle_h3_white = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: _letterSpacing,
  );

  static const TextStyle textStyle_h4_black = TextStyle(
    fontSize: 16,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    letterSpacing: _letterSpacing,
  );

  static const TextStyle textStyle_body_black = TextStyle(
    fontSize: 18,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
  );

  static const TextStyle textStyle_body_white = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
  );

  static const textStyle_body_black_crossed = TextStyle(
    fontSize: 18,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle textStyle_body_white_crossed = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle textStyle_body_small = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
  );

  static const TextStyle textStyle_body_small_red = TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
  );

  //Color switches
  static const Color color_accent_1 = Color.fromRGBO(3, 37, 76, 1);

  static const Color color_accent_2 = Color.fromRGBO(17, 103, 177, 1);

  static const Color color_accent_3 = Color.fromRGBO(24, 123, 205, 1);

  static const Color color_accent_4 = Color.fromRGBO(42, 157, 244, 1);

  static const Color color_accent_5 = Color.fromRGBO(208, 239, 255, 1);

  static const Color color_dark_black = Color.fromRGBO(20, 20, 20, 1);

  //Border radius details
  static BorderRadius borderRadius = BorderRadius.circular(8);

  //Global padding
  static const EdgeInsetsGeometry bezelPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: 10);

  static const EdgeInsetsGeometry bezelPaddingVertical =
      EdgeInsets.symmetric(vertical: 20);

  static const EdgeInsetsGeometry bezelPaddingAll =
      EdgeInsets.symmetric(horizontal: 10, vertical: 20);

  static const EdgeInsetsGeometry todoItemSpacing =
      EdgeInsets.symmetric(vertical: 1, horizontal: 0);

  //Row element padding
  static const EdgeInsetsGeometry rowItemPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 9);

  //Icon details
  static const double iconSize = 28.0;
}
