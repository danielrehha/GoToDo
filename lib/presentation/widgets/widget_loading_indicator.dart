import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gotodo/presentation/theme/custom_theme_v1.1.dart';

Widget LoadingIndicator() {
  return SpinKitCircle(
    size: 48,
    color: AppTheme.color_accent_4,
  );
}
