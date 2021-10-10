import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/pages/information.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/genres.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/rating.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MovieCard extends StatelessWidget {
  final FeedModelObjectList? feedModelObjectList;

  const MovieCard({Key? key, this.feedModelObjectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _background = Theme.of(context).backgroundColor;
    final _radius = 16.0;
    final _padding = 16.0;
    final _mainAlign = MainAxisAlignment.spaceBetween;
    final _crossAlign = CrossAxisAlignment.start;

    return Padding(
      padding: EdgeInsets.only(
        bottom: _padding,
        left: _padding,
        right: _padding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Information(
                  feedModelObjectList: feedModelObjectList,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(_padding),
            child: Row(
              mainAxisAlignment: _mainAlign,
              crossAxisAlignment: _crossAlign,
              children: [
                Expanded(
                  flex: 7,
                  child: Row(
                    crossAxisAlignment: _crossAlign,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Poster(
                          image: feedModelObjectList!.image!.medium,
                          id: feedModelObjectList!.id.toString(),
                        ),
                      ),
                      HSpace(16),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: _crossAlign,
                          children: [
                            _title(context, feedModelObjectList!.name ?? ""),
                            VSpace(8),
                            Genres(
                              genres: feedModelObjectList!.genres,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Rating(
                    rating: feedModelObjectList!.rating!.average.toString(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _title(BuildContext context, title) {
    final _textColor = Theme.of(context).canvasColor;
    final _textWeight = FontWeight.bold;
    final _textSize = 18.0;

    return Text(
      title,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
        fontSize: _textSize,
      ),
    );
  }
}
