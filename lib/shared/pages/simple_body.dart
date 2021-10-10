import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleBody extends StatelessWidget {
  final Widget header;
  final Widget body;
  final double headerHeight;

  const SimpleBody({
    Key? key,
    required this.header,
    required this.body,
    this.headerHeight = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Theme.of(context).dialogBackgroundColor;
    final _align = CrossAxisAlignment.stretch;
    final _statusPadding = MediaQuery.of(context).padding.top;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: RepaintBoundary(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: _statusPadding),
              child: Column(
                crossAxisAlignment: _align,
                children: <Widget>[
                  Container(
                    height: headerHeight + _statusPadding,
                    child: header,
                  ),
                  body,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
