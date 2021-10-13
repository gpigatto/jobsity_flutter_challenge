import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/pages/favorite_list.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/menu/presentation/widgets/menu_button.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  _MenuBodyState createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  bool logged = false;
  String user = "";
  int id = -1;

  _getRandomGreeting() {
    var greetings = ["Hey", "Hello", "Hi", "Hai", "Howdy"];

    var _random = new Random();

    return greetings[_random.nextInt(greetings.length)];
  }

  @override
  void initState() {
    context.read<GetLoggedBloc>().add(GetLoggedLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetLoggedBloc, GetLoggedState>(
      listener: (context, state) async {
        if (state is GetLoggedLoaded) {
          setState(() {
            logged = state.logged;
            user = state.user.username;
            id = state.user.id;
          });
        }
      },
      child: Padding(
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
                  title: "My Favorites",
                  icon: Icons.star_border,
                  function: () {
                    if (logged) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteList(),
                        ),
                      );
                    } else {
                      _errorToast("Sign In First..");
                    }
                  },
                ),
                VSpace(16),
              ],
            )
          ],
        ),
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
            "${_getRandomGreeting()}" + (logged ? ", " : "!"),
            style: TextStyle(
              color: _textColor,
              fontWeight: _textWeight,
              fontSize: _textSize,
            ),
          ),
          Text(
            user,
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

  _errorToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.darkAccent,
      textColor: AppTheme.accentBackground,
      fontSize: 16.0,
    );
  }
}
