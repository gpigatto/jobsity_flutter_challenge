import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/animation_cubit.dart';

final _headerHeight = 120.0;
final _cutOutHeight = 40.0;

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

  bool _inStatic = false;
  bool _inAnimation = false;
  bool _inOpacity = false;

  @override
  void initState() {
    super.initState();

    _animateContainer();
  }

  _animateContainer() {
    // check if animation will happen
    _inAnimation = !widget.showAnimation;
    _inStatic = !widget.showAnimation;
    _inOpacity = !widget.showAnimation;

    if (widget.showAnimation) {
      context.read<AnimationCubit>().enabled();

      // duration in static form
      var _staticDuration = 2000;

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: _staticDuration), () {
          if (mounted) {
            setState(() {
              _inStatic = true;
            });

            context.read<AnimationCubit>().disabled();
          }
        });
      });

      // duration between the static form and header animation + offset
      var _offset = 100;

      var _inAnimationDuration =
          _staticDuration + _animationTime.inMilliseconds + _offset;

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: _inAnimationDuration), () {
          if (mounted) {
            setState(() {
              _inAnimation = true;
            });
          }
        });
      });

      // duration between the static form and header animation + animation offset + offset
      var _inOpacityDuration = _inAnimationDuration + _offset;

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: _inOpacityDuration), () {
          if (mounted) {
            setState(() {
              _inOpacity = true;
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
              // to avoid overlap error
              _inAnimation ? _home() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _home() {
    final _height = MediaQuery.of(context).size.height - _headerHeight;
    final _opacityAnimationDuration = Duration(milliseconds: 400);

    // animate opacity after rendered
    return AnimatedOpacity(
      opacity: _inOpacity ? 1 : 0,
      curve: _animationCurve,
      duration: _opacityAnimationDuration,
      child: Stack(
        children: [
          Container(
            height: _height,
            child: widget.home,
          ),
          TopCutOut(
            height: _cutOutHeight,
          ),
        ],
      ),
    );
  }

  _header() {
    final _headerColor = AppTheme().colors.backGround;
    final _headerAnimation = Curves.easeInOutQuint;
    // (_cutOutHeight / 3) = half + 1/2 cut half
    final _statusPadding =
        MediaQuery.of(context).padding.top + (_cutOutHeight / 3);

    double _currentHeaderHeight;

    // when in static show header full screen
    if (_inStatic) {
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

class TopCutOut extends StatelessWidget {
  final double height;

  const TopCutOut({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          child: Stack(
            children: [
              _cutShadow(height),
              _cut(height),
            ],
          ),
        ),
      ],
    );
  }

  _cut(height) {
    final _bottomCutColor = AppTheme().colors.backGround;
    final _bottomCutColorRadius = 16.0;

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _bottomCutColor,
        BlendMode.srcOut,
      ),
      // set the height
      child: Container(
        child: Column(
          children: [
            // remove top half (used to overlap the shadow)
            Container(
              height: (height / 2) - 1,
              decoration: BoxDecoration(
                color: Colors.green,
                backgroundBlendMode: BlendMode.dstOut,
              ),
            ),
            // cut part
            Container(
              height: (height / 2) - 1,
              decoration: BoxDecoration(
                color: _bottomCutColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_bottomCutColorRadius),
                  topRight: Radius.circular(_bottomCutColorRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cutShadow(height) {
    final _shadow = AppTheme().shadow.shadow3;

    return Container(
      height: height / 2,
      decoration: BoxDecoration(
        boxShadow: [_shadow],
      ),
    );
  }
}
