import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class EpisodeDialog extends StatelessWidget {
  final EpisodeListModelObjectList episode;

  const EpisodeDialog({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _radius = 16.0;
    final _padding = 120.0;

    final _minSize = MainAxisSize.min;

    final _mainAxis = MainAxisAlignment.spaceBetween;
    final _crossAxis = CrossAxisAlignment.start;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
      ),
      content: Builder(
        builder: (context) {
          var width = MediaQuery.of(context).size.width - _padding;

          return Container(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: _minSize,
                children: [
                  Poster(
                    image: episode.image != null ? episode.image!.original : "",
                    id: episode.id.toString(),
                    aspectRatio: [2, 3],
                  ),
                  VSpace(24),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: _mainAxis,
                        crossAxisAlignment: _crossAxis,
                        children: [
                          _episode(),
                          _season(),
                        ],
                      ),
                      VSpace(8),
                      _name(),
                      VSpace(24),
                      _summary(context),
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

  _summary(BuildContext context) {
    final _color = AppTheme().colors.base;
    final _radius = 16.0;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Html(
          data: episode.summary ?? "",
        ),
      ),
    );
  }

  _season() {
    final _textWeight = AppTheme().fontWeight.thin;
    final _textSize = 14.0;

    return Text(
      "Season ${episode.season}",
      style: TextStyle(
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }

  _episode() {
    final _textWeight = AppTheme().fontWeight.thin;
    final _textSize = 14.0;

    return Text(
      "Episode ${episode.number}",
      style: TextStyle(
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }

  _name() {
    final _textWeight = AppTheme().appFontWeight.bold;
    final _textSize = 22.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${episode.name}",
          style: TextStyle(
            fontWeight: _textWeight,
            fontSize: _textSize,
          ),
        ),
      ],
    );
  }
}
