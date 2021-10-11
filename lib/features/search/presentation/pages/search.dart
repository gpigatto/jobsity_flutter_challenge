import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/submit_cubit.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/widgets/search_body.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/widgets/search_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitCubit(),
      child: SimpleBody(
        header: SearchHeader(),
        body: SearchBody(),
        scrollable: false,
        headerHaveHeight: false,
      ),
    );
  }
}
