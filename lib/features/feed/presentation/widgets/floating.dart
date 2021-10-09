import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _leftPadding = 32.0;
    final _align = MainAxisAlignment.spaceBetween;

    return Padding(
      padding: EdgeInsets.only(left: _leftPadding),
      child: Row(
        mainAxisAlignment: _align,
        children: [
          SizedBox(),
          _iconButton(
            context: context,
            onPressed: () {},
            icon: Icons.search,
          ),
        ],
      ),
    );
  }

  _iconButton({required context, onPressed, icon}) {
    final _buttonPadding = 20.0;
    final _buttonColor = Theme.of(context).accentColor;

    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(
        icon,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(_buttonPadding),
        primary: _buttonColor,
      ),
    );
  }
}
