import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/animation_cubit.dart';

final _headerHeight = 120.0;

class AnimatedBody extends StatelessWidget {
  final Widget home;
  final Widget header;
  final bool showAnimation;

  const AnimatedBody({
    Key? key,
    required this.home,
    required this.header,
    required this.showAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnimationCubit(),
      child: _AnimatedBody(
        header: header,
        home: home,
        showAnimation: showAnimation,
      ),
    );
  }
}

class _AnimatedBody extends StatefulWidget {
  final Widget home;
  final Widget header;
  final bool showAnimation;

  const _AnimatedBody({
    Key? key,
    required this.home,
    required this.header,
    required this.showAnimation,
  }) : super(key: key);

  @override
  __AnimatedBodyState createState() => __AnimatedBodyState();
}

class __AnimatedBodyState extends State<_AnimatedBody> {
  final _animationTime = Duration(milliseconds: 800);
  final _animationCurve = Curves.easeIn;

  bool _inAnimation = false;

  @override
  void initState() {
    super.initState();

    _animateContainer();
  }

  _animateContainer() {
    _inAnimation = !widget.showAnimation;
    context.read<AnimationCubit>().enabled();

    if (widget.showAnimation) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _inAnimation = true;
              context.read<AnimationCubit>().disabled();
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Theme.of(context).dialogBackgroundColor;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: RepaintBoundary(
          child: Column(
            children: <Widget>[
              _header(),
              _inAnimation ? _home() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _home() {
    final _bodyColor = Theme.of(context).dialogBackgroundColor;
    final _headerColor = Theme.of(context).backgroundColor;

    final _headerAnimation = Curves.easeInOutQuint;

    final _bodyBorderRadius = 24.0;

    final _height = MediaQuery.of(context).size.height - _headerHeight;

    return AnimatedOpacity(
      opacity: _inAnimation ? 1 : 0,
      curve: _animationCurve,
      duration: _animationTime,
      child: AnimatedContainer(
        color: _headerColor,
        duration: _animationTime,
        curve: _headerAnimation,
        child: Container(
          height: _height,
          child: widget.home,
          decoration: BoxDecoration(
            color: _bodyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_bodyBorderRadius),
              topRight: Radius.circular(_bodyBorderRadius),
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    final _headerColor = Theme.of(context).backgroundColor;

    final _headerAnimation = Curves.easeInOutQuint;

    final _statusPadding = MediaQuery.of(context).padding.top;

    double _currentHeaderHeight;

    if (_inAnimation) {
      _currentHeaderHeight = _headerHeight;
    } else {
      _currentHeaderHeight = MediaQuery.of(context).size.height;
    }

    return AnimatedContainer(
      color: _headerColor,
      height: _currentHeaderHeight,
      duration: _animationTime,
      curve: _headerAnimation,
      child: Padding(
        padding: EdgeInsets.only(top: _statusPadding),
        child: widget.header,
      ),
    );
  }
}
