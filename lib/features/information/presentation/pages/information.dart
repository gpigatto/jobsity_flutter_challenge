import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/movie_card.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/episodes.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/information_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/genres.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/rating.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class Information extends StatelessWidget {
  final FeedModelObjectList? feedModelObjectList;

  const Information({
    Key? key,
    required this.feedModelObjectList,
  }) : super(key: key);

  getDate(premiered, ended) {
    final format = new DateFormat('MM/dd/yyyy');

    var result = format.format(DateTime.parse(premiered));

    if (ended != null) {
      result = "$result to " + format.format(DateTime.parse(ended));
    } else {
      result = "$result to Today";
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _outerPadding = 16.0;
    final _posterPadding = 64.0;

    final _crossAlign = CrossAxisAlignment.start;
    final _mainAlign = MainAxisAlignment.spaceBetween;

    return SimpleBody(
      header: InfomationHeader(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _outerPadding),
        child: Column(
          crossAxisAlignment: _crossAlign,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _posterPadding),
              child: Poster(
                image: feedModelObjectList!.image!.original,
                id: feedModelObjectList!.id.toString(),
              ),
            ),
            VSpace(24),
            Row(
              mainAxisAlignment: _mainAlign,
              children: [
                Expanded(
                  flex: 7,
                  child: _information(context),
                ),
                Expanded(
                  flex: 1,
                  child: Rating(
                    rating: feedModelObjectList!.rating!.average.toString(),
                  ),
                )
              ],
            ),
            VSpace(24),
            _summary(context),
            VSpace(24),
            Genres(genres: feedModelObjectList!.genres),
            VSpace(8),
            Divider(thickness: 2),
            VSpace(8),
            Episodes(showId: feedModelObjectList!.id!),
            VSpace(16),
          ],
        ),
      ),
    );
  }

  _information(BuildContext context) {
    final _crossAlign = CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: _crossAlign,
      children: [
        _title(context, feedModelObjectList!.name ?? ""),
        VSpace(8),
        _date(
          context,
          getDate(
            feedModelObjectList!.premiered,
            feedModelObjectList!.ended,
          ),
        ),
      ],
    );
  }

  _title(BuildContext context, title) {
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

  _date(BuildContext context, title) {
    final _textSize = 14.0;

    return Text(
      title,
      style: TextStyle(
        fontSize: _textSize,
      ),
    );
  }

  _summary(BuildContext context) {
    final _color = Theme.of(context).backgroundColor;
    final _radius = 16.0;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
      ),
      child: Html(
        data: feedModelObjectList!.summary ?? "",
      ),
    );
  }
}