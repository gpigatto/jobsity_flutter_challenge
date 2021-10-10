import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/page_cubit.dart';
import 'package:jobsity_flutter_challenge/shared/pages/body_component.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (_) => FeedBloc(serviceLocator()),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  var itemList = [];
  var currentPage = 0;

  @override
  void initState() {
    context.read<FeedBloc>().add(FeedLoad(currentPage));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: will pop scope
    return MultiBlocListener(
      listeners: [
        BlocListener<FeedBloc, FeedState>(
          listener: (context, state) {
            if (state is FeedLoaded) {
              setState(() {
                itemList.addAll(state.feedModel.ObjectList!);
              });

              context.read<PageCubit>().reset();

              currentPage++;

              Navigator.pop(context);
            }
          },
        ),
        BlocListener<PageCubit, bool>(
          listener: (context, state) {
            if (state) {
              _loading();
              context.read<FeedBloc>().add(FeedLoad(currentPage));
            }
          },
        ),
      ],
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) => MovieCard(
          feedModelObjectList: itemList[i],
        ),
        itemCount: itemList.length,
      ),
    );
  }

  _loading() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          color: Colors.transparent,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
