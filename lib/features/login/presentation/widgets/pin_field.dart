import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinField extends StatelessWidget {
  final String title;
  final Function onComplete;

  const PinField({
    Key? key,
    required this.title,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _padding = 16.0;
    final _radius = 16.0;

    final _shadow = AppTheme().shadow.shadow2;
    final _background = AppTheme().colors.backGround;

    return Container(
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Padding(
        padding: EdgeInsets.all(_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pinTitle(title),
            VSpace(16),
            _pin(
              context,
              (value) => {onComplete(value)},
            )
          ],
        ),
      ),
    );
  }

  _pin(BuildContext context, Function onComplete) {
    final _innerRadius = 8.0;

    final _textColor = AppTheme().fontColors.base;
    final _background = AppTheme().colors.backGround;
    final _activeColor = AppTheme().colors.highlight;

    final _shape = PinCodeFieldShape.box;
    final _length = 4;

    final _animation = AnimationType.fade;
    final _animationDuration = Duration(milliseconds: 300);

    return PinCodeTextField(
      appContext: context,
      length: _length,
      obscureText: true,
      animationType: _animation,
      cursorColor: _textColor,
      pinTheme: PinTheme(
        shape: _shape,
        borderRadius: BorderRadius.circular(_innerRadius),
        activeFillColor: _background,
        activeColor: _activeColor,
        selectedColor: _activeColor,
        selectedFillColor: _activeColor,
        inactiveColor: _activeColor,
        inactiveFillColor: _background,
      ),
      animationDuration: _animationDuration,
      enableActiveFill: true,
      onCompleted: (v) => onComplete(v),
      onChanged: (value) => {},
      beforeTextPaste: (text) {
        return false;
      },
      keyboardType: TextInputType.number,
      autoFocus: true,
    );
  }

  _pinTitle(title) {
    final _textColor = AppTheme().fontColors.base;
    final _textSize = 20.0;

    final _icon = Icons.lock;
    final _iconColor = AppTheme().colors.dark;

    return Row(
      children: [
        Icon(
          Icons.lock,
          color: _iconColor,
        ),
        HSpace(4),
        Text(
          title,
          style: TextStyle(
            color: _textColor,
            fontSize: _textSize,
          ),
        ),
      ],
    );
  }
}
