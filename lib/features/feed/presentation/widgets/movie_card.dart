import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';
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
      padding: EdgeInsets.only(bottom: _padding),
      child: Container(
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
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
                      child: _Poster(
                        image: feedModelObjectList!.image!.medium,
                        id: feedModelObjectList!.id.toString(),
                      ),
                    ),
                    HSpace(16),
                    Expanded(
                      flex: 2,
                      child: _Information(
                        title: feedModelObjectList!.name ?? "",
                        genres: feedModelObjectList!.genres,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _Rating(
                  rating: feedModelObjectList!.rating!.average.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Poster extends StatefulWidget {
  final String? image;
  final String? id;

  const _Poster({Key? key, this.image, this.id}) : super(key: key);

  @override
  __PosterState createState() => __PosterState();
}

class __PosterState extends State<_Poster> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    // Check if image in viewport
    return VisibilityDetector(
      key: Key(widget.id!),
      onVisibilityChanged: (VisibilityInfo info) {
        // Get image when in view port
        var _image = new Image.network(
          widget.image!,
        );
        // Resolve image before showing
        _image.image.resolve(new ImageConfiguration()).addListener(
          new ImageStreamListener(
            (info, call) {
              setState(() {
                _loading = false;
              });
            },
          ),
        );
      },
      child: !_loading ? _image(widget.image) : _loadingCard(),
    );
  }

  _loadingCard() {
    final _ratio = (3 / 2);
    final _radius = 16.0;
    final _color = Theme.of(context).accentColor;
    final _loaderColor = Theme.of(context).backgroundColor;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: (constraints.maxWidth * _ratio),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: _loaderColor,
            ),
          ),
        );
      },
    );
  }

  _image(image) {
    final _ratio = (3 / 2);
    final _radius = 16.0;
    final _fit = BoxFit.fill;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: (constraints.maxWidth * _ratio),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: _fit,
            ),
          ),
        );
      },
    );
  }
}

class _Information extends StatelessWidget {
  final String title;
  final List<String?>? genres;

  const _Information({
    Key? key,
    required this.title,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _align = CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: _align,
      children: [
        _title(context),
        Wrap(
          children: genres!.map(
            (item) {
              return _genre(context, item!);
            },
          ).toList(),
        ),
      ],
    );
  }

  _title(BuildContext context) {
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

  Widget _genre(BuildContext context, String item) {
    final _padding = 4.0;
    final _radius = 8.0;
    final _color = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.only(right: _padding, bottom: _padding),
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(_padding),
          child: _text(context, item),
        ),
      ),
    );
  }

  _text(BuildContext context, String item) {
    final _textColor = Theme.of(context).backgroundColor;
    final _textWeight = FontWeight.bold;

    return Text(
      item,
      style: TextStyle(
        color: _textColor,
        fontWeight: _textWeight,
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  final String rating;

  const _Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = Theme.of(context).accentColor;
    final _radius = 16.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get same size to be square
        final squareSize = min(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return Container(
          height: squareSize,
          width: squareSize,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
          ),
          child: _text(context),
        );
      },
    );
  }

  _text(BuildContext context) {
    final _fit = BoxFit.fitWidth;
    final _color = Theme.of(context).backgroundColor;
    final _weight = FontWeight.bold;

    return Center(
      child: FittedBox(
        fit: _fit,
        child: Text(
          rating,
          style: TextStyle(
            color: _color,
            fontWeight: _weight,
          ),
        ),
      ),
    );
  }
}
