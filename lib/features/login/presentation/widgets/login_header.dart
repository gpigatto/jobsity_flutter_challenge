import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _iconButton = Icons.arrow_back_ios_new;
    final _padding = 26.0;

    return Padding(
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
            child: Center(
              child: _title(context, "Login"),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = AppTheme().appFontWeight.bold;
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
