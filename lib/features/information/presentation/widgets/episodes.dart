import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/bloc/episodes_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/episode_card.dart';

class Item {
  Item({
    required this.episodeList,
    required this.season,
    this.isExpanded = false,
  });

  List<EpisodeListModelObjectList> episodeList;
  int season;
  bool isExpanded;
}

class Episodes extends StatelessWidget {
  final int showId;

  const Episodes({Key? key, required this.showId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EpisodeListBloc>(
      create: (_) => EpisodeListBloc(serviceLocator()),
      child: _Episodes(showId: showId),
    );
  }
}

class _Episodes extends StatefulWidget {
  final int showId;

  const _Episodes({Key? key, required this.showId}) : super(key: key);

  @override
  __EpisodesState createState() => __EpisodesState();
}

class __EpisodesState extends State<_Episodes> {
  String dropdownValue = "";
  int index = 0;

  @override
  void initState() {
    context.read<EpisodeListBloc>().add(EpisodeListLoad(widget.showId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeListBloc, EpisodeListState>(
      builder: (context, state) {
        if (state is EpisodeListGroupedBySeason) {
          List<List<EpisodeListModelObjectList>> seasonList = [];
          List<String> indexList = [];

          state.grouped.forEach((i, season) {
            List<EpisodeListModelObjectList> episodeList = [];

            season.forEach((episode) {
              episodeList.add(episode);
            });

            seasonList.add(episodeList);

            indexList.add("Season ${season.first.season}");
          });

          if (dropdownValue == "") {
            dropdownValue = "Season ${seasonList.first.first.season}";
          }

          return Column(
            children: [
              Column(
                children: [
                  _seasonSelect(indexList, seasonList),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) => EpisodeCard(
                      episode: seasonList[index][i],
                    ),
                    itemCount: seasonList[index].length,
                  ),
                ],
              ),
            ],
          );
        }

        return SizedBox();
      },
    );
  }

  _seasonSelect(List<String> indexList,
      List<List<EpisodeListModelObjectList>> seasonList) {
    var _align = MainAxisAlignment.end;
    var _rightPadding = 16.0;

    var _verticalButtonPadding = 2.0;
    var _horizontalButtonPadding = 16.0;
    var _radius = 16.0;

    var _iconSize = 24.0;
    var _elevation = 16;

    return Padding(
      padding: EdgeInsets.only(right: _rightPadding),
      child: Row(
        mainAxisAlignment: _align,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _verticalButtonPadding,
                  horizontal: _horizontalButtonPadding),
              child: DropdownButton<String>(
                value: dropdownValue,
                underline: SizedBox(),
                iconSize: _iconSize,
                elevation: _elevation,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    index = indexList.indexOf(newValue);
                  });
                },
                items: seasonList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: "Season ${value.first.season}",
                    child: Text("Season ${value.first.season}"),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
