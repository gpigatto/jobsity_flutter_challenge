import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/pages/feed.dart';

void main() async {
  await initServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobsity Movie Database',
      theme: ThemeData(
        accentColor: Colors.orange,
        primaryColor: Colors.blue,
        canvasColor: Colors.black87,
        backgroundColor: Colors.white,
        dialogBackgroundColor: Colors.blue.shade50,
      ),
      home: Feed(),
    );
  }
}
