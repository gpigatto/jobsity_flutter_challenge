import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/logout_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogoutBloc>(
      create: (BuildContext context) => LogoutBloc(serviceLocator()),
      child: _LogoutDialog(),
    );
  }
}

class _LogoutDialog extends StatefulWidget {
  @override
  __LogoutDialogState createState() => __LogoutDialogState();
}

class __LogoutDialogState extends State<_LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    final _radius = 16.0;
    final _padding = 120.0;

    final _minSize = MainAxisSize.min;

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoaded) {
          if (state.success) {
            Fluttertoast.showToast(
              msg: "Bye!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppTheme.highlight,
              textColor: AppTheme.fontColor,
              fontSize: 16.0,
            );

            context.read<GetLoggedBloc>().add(GetLoggedLoad());

            Navigator.pop(context);
          }
        }
      },
      child: AlertDialog(
        title: _title(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        content: Builder(
          builder: (context) {
            var width = MediaQuery.of(context).size.width - _padding;

            return Container(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: _minSize,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _text(),
                    VSpace(24),
                    _signOut(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _title() {
    final _title = "Sign Out";
    final _textColor = AppTheme.fontColor;
    final _fontWeight = AppTheme.fontWeightBold;
    final _textSize = 22.0;

    return Text(
      _title,
      style: TextStyle(
        color: _textColor,
        fontSize: _textSize,
        fontWeight: _fontWeight,
      ),
    );
  }

  _text() {
    final _title = "Do you really want to sign out?";
    final _textColor = AppTheme.fontColor;
    final _textSize = 20.0;

    return Text(
      _title,
      style: TextStyle(
        color: _textColor,
        fontSize: _textSize,
      ),
    );
  }

  _signOut() {
    final _text = "Sign Out";
    final _color = AppTheme.darkAccent;
    final _textColor = AppTheme.accentBackground;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 20.0;
    final _radius = 12.0;
    final _padding = 16.0;
    final _shadow = AppTheme.shadow0;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<LogoutBloc>().add(LogoutLoad());
          },
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(_padding),
            child: Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textColor,
                fontWeight: _textWeight,
                fontSize: _textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
