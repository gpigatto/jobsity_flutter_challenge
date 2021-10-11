import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class Genres extends StatelessWidget {
  final List<String?>? genres;

  const Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: genres!.map(
        (item) {
          return _genre(context, item!);
        },
      ).toList(),
    );
  }

  Widget _genre(BuildContext context, String item) {
    final _padding = 4.0;
    final _innerPaddingHorizontal = 6.0;
    final _innerPaddingVertical = 2.0;
    final _radius = 8.0;
    final _color = AppTheme.accentBackground;

    return Padding(
      padding: EdgeInsets.only(right: _padding, bottom: _padding),
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _innerPaddingHorizontal,
            vertical: _innerPaddingVertical,
          ),
          child: _text(context, item),
        ),
      ),
    );
  }

  _text(BuildContext context, String item) {
    final _textColor = AppTheme.darkAccent;
    final _textWeight = AppTheme.fontWeightBold;

    return Text(
      item,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
      ),
    );
  }
}
