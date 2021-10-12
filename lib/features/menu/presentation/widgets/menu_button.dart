import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;

  const MenuButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      onTap: () => function(),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _icon(),
                  HSpace(8),
                  _title(),
                ],
              ),
              _leading()
            ],
          ),
        ),
      ),
    );
  }

  _leading() {
    final _color = AppTheme.fontColor;

    return Icon(
      Icons.play_arrow_rounded,
      color: _color,
    );
  }

  _icon() {
    final _color = AppTheme.fontColor;
    final _backgroudColor = AppTheme.accentBackground;
    final _radius = 12.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get same size to be square
        final squareSize = min(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return Container(
          height: squareSize,
          width: squareSize,
          decoration: BoxDecoration(
            color: _backgroudColor,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
          ),
          child: Icon(icon, color: _color),
        );
      },
    );
  }

  _title() {
    final _textColor = AppTheme.fontColor;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 20.0;

    return Text(
      title,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }
}
