import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleBody extends StatelessWidget {
  final Widget header;
  final Widget body;
  final double headerHeight;
  final bool scrollable;
  final bool headerHaveHeight;

  const SimpleBody({
    Key? key,
    required this.header,
    required this.body,
    this.headerHeight = 48.0,
    this.scrollable = true,
    this.headerHaveHeight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Theme.of(context).dialogBackgroundColor;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: RepaintBoundary(
          child: _getBody(context),
        ),
      ),
    );
  }

  _getBody(BuildContext context) {
    final _align = CrossAxisAlignment.stretch;
    final _statusPadding = MediaQuery.of(context).padding.top;

    if (scrollable) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: _statusPadding),
          child: Column(
            crossAxisAlignment: _align,
            children: <Widget>[
              Container(
                height: headerHaveHeight ? headerHeight + _statusPadding : null,
                child: header,
              ),
              body,
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: _statusPadding),
        child: Column(
          crossAxisAlignment: _align,
          children: <Widget>[
            Container(
              height: headerHaveHeight ? headerHeight + _statusPadding : null,
              child: header,
            ),
            Expanded(child: body)
          ],
        ),
      );
    }
  }
}
