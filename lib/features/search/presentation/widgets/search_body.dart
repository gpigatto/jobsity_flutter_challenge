import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/features/search/model/search_show_model.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/search_show_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/submit_cubit.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/pages/animated_body.dart';

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchShowBloc>(
      create: (_) => SearchShowBloc(serviceLocator()),
      child: _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  @override
  __SearchBodyState createState() => __SearchBodyState();
}

class __SearchBodyState extends State<_SearchBody> {
  var _itemList = [];

  @override
  Widget build(BuildContext context) {
    final _cutOutHeight = 41.0;
    final _animationTime = Duration(milliseconds: 400);

    return MultiBlocListener(
      listeners: [
        BlocListener<SubmitCubit, String>(
          listener: (context, state) {
            context.read<SearchShowBloc>().add(SearchShowLoad(state));
          },
        ),
        BlocListener<SearchShowBloc, SearchShowState>(
          listener: (context, state) {
            if (state is SearchShowLoaded) {
              setState(() {
                _itemList = state.searchShowModel.ObjectList!;
              });
            }
          },
        ),
      ],
      child: Stack(
        children: [
          _placeholder(_animationTime),
          _list(_animationTime),
          TopCutOut(
            height: _cutOutHeight,
          ),
        ],
      ),
    );
  }

  _list(Duration _animationTime) {
    return AnimatedOpacity(
      duration: _animationTime,
      opacity: _itemList.length > 0 ? 1 : 0,
      child: ListView.builder(
        itemBuilder: (context, i) {
          SearchShowModelObjectList item = _itemList[i];

          try {
            var hasImage = item.theShow!.image != null;

            var showItem = ShowItem(
              id: item.theShow!.id,
              name: item.theShow!.name,
              rating: item.theShow!.rating!.average,
              premiered: item.theShow!.premiered,
              ended: item.theShow!.ended,
              genres: item.theShow!.genres,
              imageMedium: hasImage ? item.theShow!.image!.medium : "",
              imageOriginal: hasImage ? item.theShow!.image!.original : "",
              summary: item.theShow!.summary,
            );

            return MovieCard(
              showItem: showItem,
            );
          } catch (e) {
            return SizedBox();
          }
        },
        itemCount: _itemList.length,
      ),
    );
  }

  _placeholder(Duration _animationTime) {
    final _align = MainAxisAlignment.center;
    final _icon = Icons.search;
    final _color = AppTheme().colors.highlight;
    final _size = 48.0;

    return AnimatedOpacity(
      duration: _animationTime,
      opacity: _itemList.length > 0 ? 0 : 1,
      child: Center(
        child: Column(
          mainAxisAlignment: _align,
          children: [
            Icon(
              _icon,
              color: _color,
              size: _size,
            ),
          ],
        ),
      ),
    );
  }
}
