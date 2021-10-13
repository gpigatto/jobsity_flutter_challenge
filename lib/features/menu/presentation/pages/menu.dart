import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/menu/presentation/widgets/menu_body.dart';
import 'package:jobsity_flutter_challenge/features/menu/presentation/widgets/menu_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleBody(
      header: MenuHeader(),
      body: MenuBody(),
      headerHaveHeight: false,
    );
  }
}
