import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/pages/favorite_list.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/pages/login.dart';
import 'package:jobsity_flutter_challenge/features/menu/presentation/widgets/about_dialog.dart'
    as dialog;
import 'package:jobsity_flutter_challenge/features/menu/presentation/widgets/menu_button.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/toast.dart';

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
                      CustomToast()
                          .errorToast("Sign in first!", ToastGravity.BOTTOM);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    }
                  },
                ),
                VSpace(16),
                MenuButton(
                  title: "About",
                  icon: Icons.gite,
                  function: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return dialog.AboutDialog();
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _hello() {
    final _textColor = AppTheme().fontColors.base;
    final _textHighlight = AppTheme().colors.highlight;
    final _textWeight = AppTheme().appFontWeight.bold;
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
}
