import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _position = 100.0;
    final _cardColor = Theme.of(context).accentColor;
    final _circleColor = Theme.of(context).backgroundColor;
    final _backgroundColor = Colors.transparent;
    final _padding = 8.0;

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: _position,
        color: _backgroundColor,
        child: Center(
          child: CircleAvatar(
            backgroundColor: _cardColor,
            child: Padding(
              padding: EdgeInsets.all(_padding),
              child: CircularProgressIndicator(
                color: _circleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
