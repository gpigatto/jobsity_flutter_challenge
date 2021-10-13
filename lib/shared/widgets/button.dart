import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final Function fuction;

  const Button({Key? key, required this.icon, required this.fuction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = AppTheme().colors.highlight;
    final _radius = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        onTap: () => fuction(),
        child: LayoutBuilder(
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
                border: Border.all(width: 1.0, color: _color),
                borderRadius: BorderRadius.all(
                  Radius.circular(_radius),
                ),
              ),
              child: Icon(icon),
            );
          },
        ),
      ),
    );
  }
}
