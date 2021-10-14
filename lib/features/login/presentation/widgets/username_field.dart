import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class UsernameField extends StatelessWidget {
  final Function onChage;
  final Function onSubmit;

  const UsernameField({
    Key? key,
    required this.onChage,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = AppTheme().colors.backGround;
    final _cursorColor = AppTheme().fontColors.base;
    final _shadow = AppTheme().shadow.shadow2;

    final _icon = Icons.person;
    final _iconColor = AppTheme().colors.dark;

    final _radius = 16.0;
    final _innerPaddingHorizontal = 8.0;
    final _innerPaddingVertical = 4.0;
    final _fontSize = 22.0;

    final _hint = "Username";

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _innerPaddingVertical,
          horizontal: _innerPaddingHorizontal,
        ),
        child: TextField(
          cursorColor: _cursorColor,
          decoration: InputDecoration(
            hintText: _hint,
            hintStyle: TextStyle(
              fontSize: _fontSize,
            ),
            border: InputBorder.none,
            icon: Icon(
              _icon,
              color: _iconColor,
            ),
          ),
          style: TextStyle(
            fontSize: _fontSize,
          ),
          onChanged: (value) => onChage(value),
          onSubmitted: (value) => onSubmit(value),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}
