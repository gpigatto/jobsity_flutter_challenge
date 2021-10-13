import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final Function function;

  const LoginButton({Key? key, required this.label, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = AppTheme().colors.dark;
    final _textColor = AppTheme().colors.backGround;
    final _textWeight = AppTheme().appFontWeight.bold;
    final _textSize = 20.0;
    final _radius = 12.0;
    final _padding = 16.0;
    final _shadow = AppTheme().shadow.shadow0;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => function(),
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(_padding),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textColor,
                fontWeight: _textWeight,
                fontSize: _textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
