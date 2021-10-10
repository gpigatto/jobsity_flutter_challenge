import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/page_cubit.dart';

final _headerHeight = 120.0;

class BodyComponent extends StatelessWidget {
  final Widget home;
  final Widget header;
  final Widget floating;
  final bool showAnimation;

  const BodyComponent({
    Key? key,
    required this.home,
    required this.header,
    required this.showAnimation,
    required this.floating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(),
      child: _BodyComponent(
        home: home,
        header: header,
        showAnimation: showAnimation,
        floating: floating,
      ),
    );
  }
}

class _BodyComponent extends StatefulWidget {
  final Widget home;
  final Widget header;
  final Widget floating;
  final bool showAnimation;

  const _BodyComponent({
    Key? key,
    required this.home,
    required this.header,
    required this.showAnimation,
    required this.floating,
  }) : super(key: key);

  @override
  __BodyComponentState createState() => __BodyComponentState();
}

class __BodyComponentState extends State<_BodyComponent> {
  final _animationTime = Duration(milliseconds: 800);
  final _animationCurve = Curves.easeIn;

  bool _inAnimation = false;

  bool _enableToCall = true;

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

    return BlocListener<PageCubit, bool>(
      listener: (context, state) {
        _enableToCall = !state;
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: _backgroundColor,
          body: RepaintBoundary(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    _enableToCall) {
                  context.read<PageCubit>().changePage();
                }

                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: _crossAlign,
                  children: _home(),
                ),
              ),
            ),
          ),
          floatingActionButton: _floating(),
        ),
      ),
    );
  }

  _home() {
    final _bodyColor = Theme.of(context).dialogBackgroundColor;
    final _headerColor = Theme.of(context).backgroundColor;

    final _headerAnimation = Curves.easeInOutQuint;

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
        curve: _animationCurve,
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

  _floating() {
    return AnimatedOpacity(
      opacity: _inAnimation ? 1 : 0,
      curve: _animationCurve,
      duration: _animationTime,
      child: widget.floating,
    );
  }
}

class BodyCenter extends StatelessWidget {
  final Widget child;

  const BodyCenter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _currentHeaderHeight =
        MediaQuery.of(context).size.height - _headerHeight;

    return Container(
      height: _currentHeaderHeight,
      child: Align(alignment: Alignment.center, child: child),
    );
  }
}
