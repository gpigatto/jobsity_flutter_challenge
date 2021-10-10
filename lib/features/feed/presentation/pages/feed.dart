import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/animated_body.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBody(
      header: FeedHeader(),
      home: FeedBody(),
      showAnimation: true,
    );
  }
}
