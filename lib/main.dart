import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/pages/feed.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';

void main() async {
  await initServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetLoggedBloc>(
          create: (BuildContext context) => GetLoggedBloc(serviceLocator()),
        ),
      ],
      child: MaterialApp(
        title: 'Jobsity Movie Database',
        home: Feed(),
      ),
    );
  }
}
