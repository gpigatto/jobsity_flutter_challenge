import 'package:flutter/material.dart';

class AppTheme {
  static final darkAccent = Colors.amber.shade800;
  static const highlight = Colors.amber;
  static final accent = Colors.amber.shade200;
  static final accentBackground = Colors.amber.shade50;
  static const backGround = Colors.white;
  static const fontColor = Colors.black87;

  static const fontWeightThin = FontWeight.w400;
  static const fontWeightBold = FontWeight.w800;

  static final shadow0 = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(1, 2),
  );

  static final shadow1 = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(1, 2),
  );

  static final shadow2 = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 2,
    offset: Offset(1, 2),
  );

  static final shadow3 = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 3,
    offset: Offset(3, 4),
  );
}
