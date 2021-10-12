import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';

class SimpleHeader extends StatelessWidget {
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
          flex: 4,
          child: SizedBox(),
        ),
      ],
    );
  }
}
