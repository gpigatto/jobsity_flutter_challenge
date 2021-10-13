import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/bloc/favorite_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/pages/animated_body.dart';

class FavoriteListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FavoriteListBody();
  }
}

class _FavoriteListBody extends StatefulWidget {
  @override
  __FavoriteListBodyState createState() => __FavoriteListBodyState();
}

class __FavoriteListBodyState extends State<_FavoriteListBody> {
  var itemList = [];

  @override
  void initState() {
    context.read<GetLoggedBloc>().add(GetLoggedLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cutOutHeight = 40.0;

    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteListBloc, FavoriteListState>(
          listener: (context, state) {
            if (state is FavoriteListLoaded) {
              setState(() {
                itemList = state.list;
              });
            }
          },
        ),
        BlocListener<GetLoggedBloc, GetLoggedState>(
          listener: (context, state) async {
            if (state is GetLoggedLoaded) {
              context.read<FavoriteListBloc>().add(
                    FavoriteListLoad(
                      state.user.id,
                    ),
                  );
            }
          },
        ),
      ],
      child: Stack(
        children: [
          Container(
            child: ListView.builder(
              itemBuilder: (context, i) {
                ShowItem item = itemList[i];

                return MovieCard(
                  showItem: item,
                );
              },
              itemCount: itemList.length,
            ),
          ),
          TopCutOut(
            height: _cutOutHeight,
          ),
        ],
      ),
    );
  }
}
