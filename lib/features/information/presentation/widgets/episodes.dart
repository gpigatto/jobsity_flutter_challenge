import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/bloc/episodes_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/episode_card.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

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
    final _align = MainAxisAlignment.end;

    final _horizontalButtonPadding = 16.0;
    final _radius = 12.0;
    final _shadow = AppTheme().shadow.shadow0;
    final _color = AppTheme().colors.highlight;

    final _iconSize = 24.0;

    final _textWeight = AppTheme().appFontWeight.bold;

    return Row(
      mainAxisAlignment: _align,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            boxShadow: [_shadow],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _horizontalButtonPadding,
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              underline: SizedBox(),
              iconSize: _iconSize,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  index = indexList.indexOf(newValue);
                });
              },
              items: seasonList.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: "Season ${value.first.season}",
                  child: Text(
                    "Season ${value.first.season}",
                    style: TextStyle(fontWeight: _textWeight),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
