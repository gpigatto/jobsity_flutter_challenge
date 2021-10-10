import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/submit_cubit.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/widgets/search_body.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitCubit(),
      child: SimpleBody(
        header: SearchHeader(),
        body: SearchBody(),
        scrollable: false,
        headerHaveHeight: false,
      ),
    );
  }
}

class SearchHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _statusPadding = MediaQuery.of(context).padding.top;
    final _verticalAlign = MainAxisAlignment.center;

    return Column(
      children: [
        VSpace(_statusPadding),
        Container(
          child: Row(
            mainAxisAlignment: _verticalAlign,
            children: [
              Expanded(
                flex: 1,
                child: _button(context),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: _title(context, "Find Your Show"),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        VSpace(8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _searchBar(context),
        ),
      ],
    );
  }

  _searchBar(BuildContext context) {
    final _color = Colors.amber;
    final _cursorColor = Colors.white;

    final _icon = Icons.search;

    final _radius = 16.0;
    final _innerPadding = 8.0;
    final _fontSize = 22.0;

    final _hint = "Search";

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(_innerPadding),
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
    );
  }

  _button(BuildContext context) {
    final _iconOffset = 8.0;
    final _icon = Icons.arrow_back_ios;

    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Padding(
        padding: EdgeInsets.only(left: _iconOffset),
        child: Icon(_icon),
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = FontWeight.bold;
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
