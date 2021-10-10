import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/bloc/episodes_list_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

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
  List<Item> _showEpisodesList = [];

  @override
  void initState() {
    context.read<EpisodeListBloc>().add(EpisodeListLoad(widget.showId));

    super.initState();
  }

  generateItems(
    Map<int?, List<EpisodeListModelObjectList>> grouped,
  ) {
    List<Item> result = [];

    grouped.forEach((i, season) {
      List<EpisodeListModelObjectList> episodeList = [];

      season.forEach((episode) {
        episodeList.add(episode);
      });

      var item = new Item(
        season: i!,
        episodeList: episodeList,
      );

      result.add(item);
    });

    setState(() {
      _showEpisodesList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodeListBloc, EpisodeListState>(
      listener: (context, state) {
        if (state is EpisodeListGroupedBySeason) {
          generateItems(state.grouped);
        }
      },
      child: _buildPanel(),
    );
  }

  Widget _buildPanel() {
    final _elevation = 0;
    final _color = Colors.transparent;

    return ExpansionPanelList(
      elevation: _elevation,
      dividerColor: _color,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _showEpisodesList[index].isExpanded = !isExpanded;
        });
      },
      children: _showEpisodesList.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: _season("Season ${item.season.toString()}"),
            );
          },
          body: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) => EpisodeCard(
              episode: item.episodeList[i],
            ),
            itemCount: item.episodeList.length,
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  _season(title) {
    final _textWeight = FontWeight.bold;
    final _textSize = 18.0;

    return Text(
      title,
      style: TextStyle(
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final EpisodeListModelObjectList episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  _showDialog(BuildContext context, EpisodeListModelObjectList episode) {
    showDialog(
      context: context,
      builder: (_) => new EpisodeDialog(episode: episode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _outerPadding = 16.0;
    final _color = Theme.of(context).accentColor;
    final _radius = 16.0;
    final _crossAlign = CrossAxisAlignment.start;
    final _mainAlign = MainAxisAlignment.spaceBetween;

    return Padding(
      padding: EdgeInsets.only(bottom: _outerPadding),
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        child: TextButton(
          onPressed: () {
            _showDialog(context, episode);
          },
          child: Row(
            mainAxisAlignment: _mainAlign,
            crossAxisAlignment: _crossAlign,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: _crossAlign,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Poster(
                        image:
                            episode.image != null ? episode.image!.medium : "",
                        id: "${episode.id}_info",
                        aspectRatio: [2, 3],
                      ),
                    ),
                    HSpace(16),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: _crossAlign,
                        children: [
                          _episode(context, "Episode ${episode.number}"),
                          _title(context, "${episode.name}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _duration(
                  context,
                  "${episode.runtime} Min",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = FontWeight.bold;
    final _color = Colors.white;
    final _textSize = 18.0;

    return Text(
      title,
      style: TextStyle(
        color: _color,
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }

  _episode(BuildContext context, title) {
    final _textSize = 14.0;
    final _color = Colors.white;

    return Text(
      title,
      style: TextStyle(
        color: _color,
        fontSize: _textSize,
      ),
    );
  }

  _duration(BuildContext context, title) {
    final _padding = 8.0;
    final _textSize = 12.0;
    final _color = Colors.white;

    return Padding(
      padding: EdgeInsets.only(right: _padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _color,
              fontSize: _textSize,
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeDialog extends StatelessWidget {
  final EpisodeListModelObjectList episode;

  const EpisodeDialog({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          var padding = 120.0;
          var width = MediaQuery.of(context).size.width - padding;

          return Container(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Poster(
                    image: episode.image!.original,
                    id: episode.id.toString(),
                    aspectRatio: [2, 3],
                  ),
                  VSpace(24),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Episode ${episode.number}"),
                                Text("${episode.name}"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Season ${episode.season}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      VSpace(24),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Html(
                          data: episode.summary ?? "",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
