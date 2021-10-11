import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/pages/information.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/genres.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/rating.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class MovieCard extends StatelessWidget {
  final ShowItem showItem;

  const MovieCard({Key? key, required this.showItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _background = AppTheme.backGround;
    final _shadow = AppTheme.shadow1;
    final _radius = 16.0;
    final _padding = 16.0;
    final _innerPadding = 4.0;
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
          boxShadow: [_shadow],
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Information(
                  showItem: showItem,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(_innerPadding),
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
                          image: showItem.imageMedium,
                          id: showItem.id.toString(),
                        ),
                      ),
                      HSpace(16),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: _crossAlign,
                          children: [
                            _title(context, showItem.name ?? ""),
                            VSpace(8),
                            Genres(
                              genres: showItem.genres,
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
                    rating: showItem.rating != null
                        ? showItem.rating.toString()
                        : "-",
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
    final _textColor = AppTheme.fontColor;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 20.0;

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
