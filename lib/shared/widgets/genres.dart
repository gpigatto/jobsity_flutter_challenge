import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final _radius = 8.0;
    final _color = Theme.of(context).primaryColor;

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
          padding: EdgeInsets.all(_padding),
          child: _text(context, item),
        ),
      ),
    );
  }

  _text(BuildContext context, String item) {
    final _textColor = Theme.of(context).canvasColor;
    final _textWeight = FontWeight.bold;

    return Text(
      item,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
      ),
    );
  }
}
