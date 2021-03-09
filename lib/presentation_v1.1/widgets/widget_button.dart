import 'package:flutter/material.dart';
import 'package:gotodo/presentation_v1.1/theme/custom_theme_v1.1.dart';

class MainButton extends StatelessWidget {
  final Color color;
  final Function function;
  final String label;
  final TextStyle labelStyle;
  const MainButton({
    Key key,
    @required this.color,
    @required this.function,
    @required this.label,
    @required this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppTheme.borderRadius,
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            label,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
        ),
        onTap: function,
      ),
    );
  }
}
