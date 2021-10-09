import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/header.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/body_component.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return BodyComponent(
      header: Header(),
      home: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              color: Theme.of(context).accentColor,
              child: const Center(child: Text('Entry A')),
            ),
          ],
        ),
      ),
      showAnimation: true,
    );
  }
}
