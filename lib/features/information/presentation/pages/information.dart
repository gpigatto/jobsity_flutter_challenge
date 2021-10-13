import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/information_body.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/information_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';

class Information extends StatelessWidget {
  final ShowItem showItem;

  const Information({
    Key? key,
    required this.showItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleBody(
      header: InformationHeader(showItem: showItem),
      body: InformationBody(showItem: showItem),
    );
  }
}
