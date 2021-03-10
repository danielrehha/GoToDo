import 'package:flutter/material.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';

class TranslateDateColor {
  static TextStyle call({@required DateTime date}) {
    final now = DateTime.now();

    if (now.year > date.year) {
      return AppTheme.textStyle_body_small_red;
    } else if (now.year == date.year &&
        now.month >= date.month &&
        now.day > date.day) {
      return AppTheme.textStyle_body_small_red;
    } else {
      return AppTheme.textStyle_body_small;
    }
  }
}
