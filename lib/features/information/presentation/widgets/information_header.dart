import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfomationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _padding = 16.0;
    final _iconOffset = 8.0;
    final _icon = Icons.arrow_back_ios;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Padding(
              padding: EdgeInsets.only(left: _iconOffset),
              child: Icon(_icon),
            ),
          ),
        ],
      ),
    );
  }
}
