import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/png_images.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _radius = 16.0;
    final _padding = 120.0;

    final _minSize = MainAxisSize.min;

    return AlertDialog(
      title: _title(),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _text(),
                      ),
                      Expanded(
                        flex: 1,
                        child: _icon(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _title() {
    final _title = "About";
    final _textColor = AppTheme().fontColors.base;
    final _fontWeight = AppTheme().appFontWeight.bold;
    final _textSize = 22.0;

    return Text(
      _title,
      style: TextStyle(
        color: _textColor,
        fontSize: _textSize,
        fontWeight: _fontWeight,
      ),
    );
  }

  _text() {
    final _title =
        "Thanks for the oportunity! It was a really fun project to build!";
    final _textColor = AppTheme().fontColors.base;
    final _textSize = 16.0;

    return Text(
      _title,
      style: TextStyle(
        color: _textColor,
        fontSize: _textSize,
      ),
    );
  }

  _icon() {
    final _color = AppTheme().colors.highlight;
    final _radius = 12.0;

    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(_radius),
      ),
      onTap: () async {
        var url = "https://github.com/gpigatto/jobsity_flutter_challenge";

        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: LayoutBuilder(
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
              border: Border.all(width: 1.0, color: _color),
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              ),
            ),
            child: ImageIcon(
              AssetImage(PngImages.githubLogo),
              color: AppTheme().fontColors.base,
            ),
          );
        },
      ),
    );
  }
}
