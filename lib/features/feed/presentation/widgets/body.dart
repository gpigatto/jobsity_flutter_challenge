import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/cubit/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/body_component.dart';

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
  @override
  void initState() {
    context.read<FeedBloc>().add(FeedLoad(0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedLoading) {
        return _loading();
      } else if (state is FeedLoaded) {
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: state.feedModel.ObjectList!.map(
              (item) {
                return MovieCard(feedModelObjectList: item);
              },
            ).toList(),
          ),
        );
      } else {
        return _error();
      }
    });
  }

  _loading() {
    final _loaderColor = Theme.of(context).accentColor;

    return BodyCenter(
      child: CircularProgressIndicator(
        color: _loaderColor,
      ),
    );
  }

  _error() {
    final _color = Theme.of(context).canvasColor;
    final _weight = FontWeight.bold;
    final _textSize = 18.0;

    return BodyCenter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oh No!",
            style: TextStyle(
              color: _color,
              fontWeight: _weight,
              fontSize: _textSize,
            ),
          ),
          Text(
            "Something went wrong, sorry..",
            style: TextStyle(
              color: _color,
            ),
          ),
        ],
      ),
    );
  }
}
