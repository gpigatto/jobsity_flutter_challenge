import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsity_flutter_challenge/shared/svg_images.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _horizontalPadding = 60.0;
    final _verticalPadding = 16.0;

    final _horizontalAlign = CrossAxisAlignment.stretch;
    final _verticalAlign = MainAxisAlignment.center;

    final _logo = SvgImages.jobsityLogo;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: Row(
        crossAxisAlignment: _horizontalAlign,
        mainAxisAlignment: _verticalAlign,
        children: [
          Expanded(
            child: SvgPicture.asset(_logo),
          ),
        ],
      ),
    );
  }
}
