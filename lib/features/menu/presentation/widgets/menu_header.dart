import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/login_dialog.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/logout_dialog.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';

class MenuHeader extends StatefulWidget {
  @override
  _MenuHeaderState createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  bool logged = false;

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        if (!logged) {
          return LoginDialog();
        } else {
          return LogoutDialog();
        }
      },
    );
  }

  @override
  void initState() {
    context.read<GetLoggedBloc>().add(GetLoggedLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _iconButton = Icons.arrow_back_ios_new;
    final _padding = 26.0;

    return BlocListener<GetLoggedBloc, GetLoggedState>(
      listener: (context, state) async {
        if (state is GetLoggedLoaded) {
          logged = state.logged;
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: _padding),
        child: Row(
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
        ),
      ),
    );
  }

  _logIn() {
    final _color = AppTheme().colors.highlight;
    final _radius = 12.0;
    final _icon = Icons.login;
    final _iconColor = AppTheme().colors.backGround;
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
                onTap: () {
                  _showDialog(context);
                },
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
