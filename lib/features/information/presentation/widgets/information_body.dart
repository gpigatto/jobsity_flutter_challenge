import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/widgets/episodes.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/genres.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/poster.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/rating.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';

class InformationBody extends StatelessWidget {
  final ShowItem showItem;

  const InformationBody({Key? key, required this.showItem}) : super(key: key);

  getDate(premiered, ended) {
    final format = new DateFormat('MM/dd/yyyy');

    var result = "";

    if (premiered != null) {
      result = format.format(DateTime.parse(premiered));
    }

    if (premiered != null && ended != null) {
      result = "$result to " + format.format(DateTime.parse(ended));
    } else if (premiered != null) {
      result = "$result to Today";
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _outerPadding = 16.0;
    final _posterPadding = 64.0;

    final _crossAlign = CrossAxisAlignment.start;

    final _informationMainAlign = MainAxisAlignment.spaceBetween;
    final _informationCrossAlign = CrossAxisAlignment.center;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _outerPadding),
      child: Column(
        crossAxisAlignment: _crossAlign,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _posterPadding),
            child: Poster(
              image: showItem.imageOriginal,
              id: showItem.id.toString(),
            ),
          ),
          VSpace(24),
          Row(
            mainAxisAlignment: _informationMainAlign,
            crossAxisAlignment: _informationCrossAlign,
            children: [
              Expanded(
                flex: 7,
                child: _information(context),
              ),
              Expanded(
                flex: 1,
                child: Rating(
                  rating: showItem.rating != null
                      ? showItem.rating.toString()
                      : "-",
                ),
              )
            ],
          ),
          VSpace(24),
          _summary(context),
          VSpace(24),
          Genres(genres: showItem.genres),
          VSpace(16),
          Episodes(showId: showItem.id!),
          VSpace(16),
        ],
      ),
    );
  }

  _information(BuildContext context) {
    final _crossAlign = CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: _crossAlign,
      children: [
        _title(context, showItem.name ?? ""),
        VSpace(4),
        _date(
          context,
          getDate(
            showItem.premiered,
            showItem.ended,
          ),
        ),
      ],
    );
  }

  _title(BuildContext context, title) {
    final _textWeight = AppTheme().appFontWeight.bold;
    final _textSize = 24.0;

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
    final _textWeight = AppTheme().fontWeight.thin;

    return Text(
      title,
      style: TextStyle(
        fontSize: _textSize,
        fontWeight: _textWeight,
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
        // boxShadow: [_shadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Html(
          data: showItem.summary ?? "",
        ),
      ),
    );
  }
}
