import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleBody(
      header: MenuHeader(),
      body: MenuBody(),
    );
  }
}

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _iconButton = Icons.arrow_back_ios_new;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Button(
            icon: _iconButton,
            fuction: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(),
        ),
        Expanded(
          flex: 1,
          child: _logIn(),
        ),
      ],
    );
  }

  _logIn() {
    final _color = AppTheme.highlight;
    final _radius = 12.0;
    final _icon = Icons.login;
    final _iconColor = AppTheme.accentBackground;
    final _padding = 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get same size to be square
          final squareSize = min(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          return Container(
            height: squareSize,
            width: squareSize,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.all(
                  Radius.circular(_radius),
                ),
                child: Icon(
                  _icon,
                  color: _iconColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenuBody extends StatelessWidget {
  const MenuBody({Key? key}) : super(key: key);

  _getRandomGreeting() {
    var greetings = ["Hey", "Hello", "Hi", "Hai", "Howdy"];

    var _random = new Random();

    return greetings[_random.nextInt(greetings.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(24),
          _hello(),
          VSpace(16),
          Divider(),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              MenuButton(
                title: "name",
                icon: Icons.ac_unit,
                function: () {
                  print('test');
                },
              ),
              VSpace(16),
            ],
          )
        ],
      ),
    );
  }

  _hello() {
    final _textColor = AppTheme.fontColor;
    final _textHighlight = AppTheme.highlight;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 42.0;

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        children: [
          Text(
            "${_getRandomGreeting()}, ",
            style: TextStyle(
              color: _textColor,
              fontWeight: _textWeight,
              fontSize: _textSize,
            ),
          ),
          Text(
            "Name",
            style: TextStyle(
              color: _textHighlight,
              fontWeight: _textWeight,
              fontSize: _textSize,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;

  const MenuButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      onTap: () => function(),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _icon(),
                  HSpace(8),
                  _title(),
                ],
              ),
              _leading()
            ],
          ),
        ),
      ),
    );
  }

  _leading() {
    final _color = AppTheme.fontColor;

    return Icon(
      Icons.play_arrow_rounded,
      color: _color,
    );
  }

  _icon() {
    final _color = AppTheme.fontColor;
    final _backgroudColor = AppTheme.accentBackground;
    final _radius = 12.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get same size to be square
        final squareSize = min(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return Container(
          height: squareSize,
          width: squareSize,
          decoration: BoxDecoration(
            color: _backgroudColor,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
          ),
          child: Icon(icon, color: _color),
        );
      },
    );
  }

  _title() {
    final _textColor = AppTheme.fontColor;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 20.0;

    return Text(
      title,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }
}
