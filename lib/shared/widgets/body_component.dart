import 'dart:async';

import 'package:flutter/material.dart';

class BodyComponent extends StatefulWidget {
  final Widget home;
  final Widget header;
  final bool showAnimation;

  const BodyComponent({
    Key? key,
    required this.home,
    required this.header,
    required this.showAnimation,
  }) : super(key: key);

  @override
  _BodyComponentState createState() => _BodyComponentState();
}

class _BodyComponentState extends State<BodyComponent> {
  bool _inAnimation = false;

  @override
  void initState() {
    super.initState();

    _animateContainer();
  }

  _animateContainer() {
    _inAnimation = !widget.showAnimation;

    if (widget.showAnimation) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _inAnimation = true;
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    final _backgroundColor = Theme.of(context).dialogBackgroundColor;
    final _crossAlign = CrossAxisAlignment.stretch;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: RepaintBoundary(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: _crossAlign,
              children: _home(),
            ),
          ),
        ),
      ),
    );
  }

  _home() {
    final _bodyColor = Theme.of(context).dialogBackgroundColor;
    final _headerColor = Theme.of(context).backgroundColor;

    final _headerAnimation = Curves.easeInOutQuint;
    final _animationTime = Duration(milliseconds: 800);

    final _headerHeight = 120.0;
    final _horizontalPadding = 16.0;
    final _bodyBorderRadius = 24.0;

    final _statusPadding = MediaQuery.of(context).padding.top;

    double _currentHeaderHeight;

    if (_inAnimation) {
      _currentHeaderHeight = _headerHeight;
    } else {
      _currentHeaderHeight = MediaQuery.of(context).size.height;
    }

    return [
      AnimatedContainer(
        color: _headerColor,
        height: _currentHeaderHeight,
        duration: _animationTime,
        curve: _headerAnimation,
        child: Padding(
          padding: EdgeInsets.only(top: _statusPadding),
          child: widget.header,
        ),
      ),
      AnimatedOpacity(
        opacity: _inAnimation ? 1 : 0,
        curve: Curves.easeIn,
        duration: _animationTime,
        child: AnimatedContainer(
          color: _headerColor,
          duration: _animationTime,
          curve: _headerAnimation,
          child: Container(
            child: widget.home,
            padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            decoration: BoxDecoration(
              color: _bodyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_bodyBorderRadius),
                topRight: Radius.circular(_bodyBorderRadius),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
