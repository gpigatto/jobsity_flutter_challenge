import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/submit_cubit.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class SearchHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _statusPadding = MediaQuery.of(context).padding.top;
    final _verticalAlign = MainAxisAlignment.center;
    final _iconButton = Icons.arrow_back_ios_new;

    return Column(
      children: [
        VSpace(_statusPadding),
        Container(
          child: Row(
            mainAxisAlignment: _verticalAlign,
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
                child: Center(
                  child: _title(context, "Find Your Show"),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        VSpace(16),
        _searchBar(context),
        VSpace(8),
      ],
    );
  }

  _searchBar(BuildContext context) {
    final _padding = 16.0;

    final _color = AppTheme.backGround;
    final _cursorColor = AppTheme.fontColor;
    final _shadow = AppTheme.shadow2;

    final _icon = Icons.search;

    final _radius = 16.0;
    final _innerPaddingHorizontal = 8.0;
    final _innerPaddingVertical = 4.0;
    final _fontSize = 22.0;

    final _hint = "Search";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
          boxShadow: [_shadow],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: _innerPaddingVertical,
            horizontal: _innerPaddingHorizontal,
          ),
          child: TextField(
            cursorColor: _cursorColor,
            decoration: InputDecoration(
              hintText: _hint,
              hintStyle: TextStyle(
                fontSize: _fontSize,
              ),
              border: InputBorder.none,
              icon: Icon(
                _icon,
                color: _cursorColor,
              ),
            ),
            style: TextStyle(
              fontSize: _fontSize,
            ),
            onSubmitted: (value) {
              context.read<SubmitCubit>().onTextChange(value);
            },
          ),
        ),
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 24.0;

    return Text(
      title,
      style: TextStyle(
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final IconData icon;
  final Function fuction;

  const Button({Key? key, required this.icon, required this.fuction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = AppTheme.highlight;
    final _radius = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        onTap: () => fuction(),
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
                border: Border.all(width: 1.0, color: _color),
                borderRadius: BorderRadius.all(
                  Radius.circular(_radius),
                ),
              ),
              child: Icon(icon),
            );
          },
        ),
      ),
    );
  }
}
