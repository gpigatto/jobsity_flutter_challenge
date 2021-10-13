import 'package:flutter/material.dart';

class AppTheme {
  final AppColors appColors = new AppColors();
  final AppFontColors appFontColors = new AppFontColors();
  final AppFontWeight appFontWeight = new AppFontWeight();
  final AppShadow appShadow = new AppShadow();

  AppColors get colors => appColors;
  AppFontColors get fontColors => appFontColors;
  AppFontWeight get fontWeight => appFontWeight;
  AppShadow get shadow => appShadow;
}

class AppColors {
  Color get dark => Colors.amber.shade800;
  Color get highlight => Colors.amber;
  Color get base => Colors.amber.shade200;
  Color get light => Colors.amber.shade50;
  Color get backGround => Colors.white;
}

class AppFontColors {
  Color get base => Colors.black87;
}

class AppFontWeight {
  FontWeight get thin => FontWeight.w400;
  FontWeight get bold => FontWeight.w800;
}

class AppShadow {
  BoxShadow get shadow0 => BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(1, 2),
      );

  BoxShadow get shadow1 => BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(1, 2),
      );

  BoxShadow get shadow2 => BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 2,
        offset: Offset(1, 2),
      );

  BoxShadow get shadow3 => BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(3, 4),
      );
}
