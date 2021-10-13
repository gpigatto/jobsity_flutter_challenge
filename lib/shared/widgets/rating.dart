import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class Rating extends StatelessWidget {
  final String rating;

  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = AppTheme().colors.highlight;
    final _radius = 12.0;
    final _shadow = AppTheme().shadow.shadow0;

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
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            boxShadow: [_shadow],
          ),
          child: _text(context),
        );
      },
    );
  }

  _text(BuildContext context) {
    final _fit = BoxFit.fitWidth;
    final _color = AppTheme().fontColors.base;
    final _weight = AppTheme().appFontWeight.bold;
    final _fontSize = 16.0;

    return Center(
      child: FittedBox(
        fit: _fit,
        child: Text(
          rating,
          style: TextStyle(
            color: _color,
            fontWeight: _weight,
            fontSize: _fontSize,
          ),
        ),
      ),
    );
  }
}
