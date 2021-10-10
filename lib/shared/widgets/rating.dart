import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final String rating;

  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = Theme.of(context).accentColor;
    final _radius = 16.0;

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
          ),
          child: _text(context),
        );
      },
    );
  }

  _text(BuildContext context) {
    final _fit = BoxFit.fitWidth;
    final _color = Theme.of(context).canvasColor;
    final _weight = FontWeight.bold;

    return Center(
      child: FittedBox(
        fit: _fit,
        child: Text(
          rating,
          style: TextStyle(
            color: _color,
            fontWeight: _weight,
          ),
        ),
      ),
    );
  }
}
