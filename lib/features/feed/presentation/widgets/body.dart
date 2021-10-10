import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
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
  ScrollController _controller = new ScrollController();

  var itemList = [];
  var currentPage = 0;
  var loading = false;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      context.read<FeedBloc>().add(FeedLoad(currentPage));

      loading = true;
      _loading();
    }
  }

  @override
  void initState() {
    context.read<FeedBloc>().add(FeedLoad(currentPage));

    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FeedLoaded) {
          setState(() {
            itemList.addAll(state.feedModel.ObjectList!);
          });

          currentPage++;

          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
        }
      },
      child: ListView.builder(
        itemBuilder: (context, i) => MovieCard(
          feedModelObjectList: itemList[i],
        ),
        itemCount: itemList.length,
        controller: _controller,
      ),
    );
  }

  _loading() {
    final _backgroundColor = Colors.transparent;
    final _position = 100.0;
    final _cardColor = Theme.of(context).accentColor;
    final _circleColor = Theme.of(context).backgroundColor;

    showModalBottomSheet<void>(
      backgroundColor: _backgroundColor,
      barrierColor: _backgroundColor,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: _position,
            color: _backgroundColor,
            child: Center(
              child: CircleAvatar(
                backgroundColor: _cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: _circleColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
