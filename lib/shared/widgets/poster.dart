import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Poster extends StatefulWidget {
  final String? image;
  final String? id;
  final List<int> aspectRatio;

  static const _ration = [3, 2];

  const Poster({
    Key? key,
    this.image,
    this.id,
    this.aspectRatio = _ration,
  }) : super(key: key);

  @override
  _PosterState createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    // Check if image in viewport
    return Hero(
      tag: widget.id!,
      child: VisibilityDetector(
        key: Key(widget.id!),
        onVisibilityChanged: (VisibilityInfo info) {
          if (widget.image != "") {
            // Get image when in view port
            var _image = new Image.network(
              widget.image!,
            );
            // Resolve image before showing
            _image.image.resolve(new ImageConfiguration()).addListener(
              new ImageStreamListener(
                (info, call) {
                  if (this.mounted) {
                    setState(() {
                      _loading = false;
                    });
                  }
                },
              ),
            );
          }
        },
        child: _checkImage(widget.image),
      ),
    );
  }

  _checkImage(image) {
    if (image == "") {
      return _icon();
    } else if (_loading) {
      return _loadingCard();
    } else {
      return _image(widget.image);
    }
  }

  _loadingCard() {
    final _radius = 16.0;
    final _color = AppTheme.highlight;
    final _loaderColor = AppTheme.fontColor;
    final _shadow = AppTheme.shadow1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: ((constraints.maxWidth * widget.aspectRatio[0]) /
              widget.aspectRatio[1]),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            boxShadow: [_shadow],
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
    final _radius = 16.0;
    final _fit = BoxFit.fill;
    final _shadow = AppTheme.shadow1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: ((constraints.maxWidth * widget.aspectRatio[0]) /
              widget.aspectRatio[1]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: _fit,
            ),
            boxShadow: [_shadow],
          ),
        );
      },
    );
  }

  _icon() {
    final _color = AppTheme.highlight;
    final _iconColor = AppTheme.fontColor;
    final _radius = 16.0;
    final _shadow = AppTheme.shadow1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: ((constraints.maxWidth * widget.aspectRatio[0]) /
              widget.aspectRatio[1]),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(_radius),
            ),
            boxShadow: [_shadow],
          ),
          child: Center(
            child: Icon(
              Icons.slideshow_rounded,
              color: _iconColor,
            ),
          ),
        );
      },
    );
  }
}
