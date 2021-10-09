import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/pages/feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobsity Movie Database',
      theme: ThemeData(
        accentColor: Colors.blue,
        backgroundColor: Colors.white,
        dialogBackgroundColor: Colors.blue.shade100,
      ),
      darkTheme: ThemeData.dark(),
      home: Feed(),
    );
  }
}
