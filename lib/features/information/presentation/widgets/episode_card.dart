import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/episode_dialog.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

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
    final _color = AppTheme.backGround;
    final _shadow = AppTheme.shadow1;
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
          boxShadow: [_shadow],
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
                flex: 2,
                child: Poster(
                  image: episode.image != null ? episode.image!.medium : "",
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
                    _title(context, "${episode.name}"),
                    _episode(context,
                        "Episode ${episode.number}    ${episode.runtime} Mins"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = AppTheme.fontWeightBold;
    final _color = AppTheme.fontColor;
    final _textSize = 20.0;

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
    final _textSize = 12.0;
    final _textWeight = AppTheme.fontWeightThin;
    final _color = AppTheme.fontColor;

    return Text(
      title,
      style: TextStyle(
        color: _color,
        fontSize: _textSize,
        fontWeight: _textWeight,
      ),
    );
  }
}
