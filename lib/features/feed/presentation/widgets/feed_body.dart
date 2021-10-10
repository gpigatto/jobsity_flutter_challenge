import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/loading_dialog.dart';

class ShowItem {
  final int? id;
  final String? imageMedium;
  final String? imageOriginal;
  final String? name;
  final List<String?>? genres;
  final double? rating;

  final String? premiered;
  final String? ended;
  final String? summary;

  ShowItem({
    required this.id,
    required this.imageMedium,
    required this.imageOriginal,
    required this.name,
    required this.genres,
    required this.rating,
    required this.premiered,
    required this.ended,
    required this.summary,
  });
}

class FeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (_) => FeedBloc(serviceLocator()),
      child: _FeedBody(),
    );
  }
}

class _FeedBody extends StatefulWidget {
  @override
  __FeedBodyState createState() => __FeedBodyState();
}

class __FeedBodyState extends State<_FeedBody> {
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
        itemBuilder: (context, i) {
          FeedModelObjectList item = itemList[i];

          var showItem = ShowItem(
            id: item.id,
            name: item.name,
            rating: item.rating!.average,
            premiered: item.premiered,
            ended: item.ended,
            genres: item.genres,
            imageMedium: item.image!.medium,
            imageOriginal: item.image!.original,
            summary: item.summary,
          );

          return MovieCard(
            showItem: showItem,
          );
        },
        itemCount: itemList.length,
        controller: _controller,
      ),
    );
  }

  _loading() {
    final _backgroundColor = Colors.transparent;

    showModalBottomSheet<void>(
      backgroundColor: _backgroundColor,
      barrierColor: _backgroundColor,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return LoadingDialog();
      },
    );
  }
}
