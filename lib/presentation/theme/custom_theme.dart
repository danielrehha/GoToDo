import 'package:flutter/material.dart';

class CustomTheme {
  static const EdgeInsetsGeometry bezelPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: 20);

  static const EdgeInsetsGeometry bezelPaddingVertical =
      EdgeInsets.symmetric(vertical: 20);

  static const EdgeInsetsGeometry bezelPaddingAll =
      EdgeInsets.symmetric(horizontal: 20, vertical: 12);

  static const EdgeInsetsGeometry todoItemSpacing =
      EdgeInsets.symmetric(vertical: 8, horizontal: 4);

  static const TextStyle h1 = TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h2 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyTextAccent = TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyText = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle buttonTextAccent = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const Color bg_color = Colors.white54;

  static const Color accent_body_main = Colors.red;
  static const Color accent_body_secondary = Colors.blue;

  static const Color divider_color = Colors.black26;
}
