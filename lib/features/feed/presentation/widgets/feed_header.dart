import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/pages/search.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/animation_cubit.dart';
import 'package:jobsity_flutter_challenge/shared/svg_images.dart';

class FeedHeader extends StatefulWidget {
  @override
  _FeedHeaderState createState() => _FeedHeaderState();
}

class _FeedHeaderState extends State<FeedHeader> {
  bool inAnimation = true;

  @override
  Widget build(BuildContext context) {
    final _horizontalPadding = 60.0;

    final _horizontalAlign = CrossAxisAlignment.stretch;
    final _verticalAlign = MainAxisAlignment.center;

    final _logo = SvgImages.jobsityLogo;

    return BlocListener<AnimationCubit, bool>(
      listener: (context, state) {
        setState(() {
          inAnimation = state;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: inAnimation ? _horizontalPadding : 0,
        ),
        child: Row(
          crossAxisAlignment: _horizontalAlign,
          mainAxisAlignment: _verticalAlign,
          children: [
            _spacer(),
            Expanded(
              flex: 2,
              child: SvgPicture.asset(_logo),
            ),
            _searchButton()
          ],
        ),
      ),
    );
  }

  _spacer() {
    if (inAnimation)
      return SizedBox();
    else
      return Expanded(flex: 1, child: Container());
  }

  _searchButton() {
    if (inAnimation)
      return SizedBox();
    else
      return Expanded(
        flex: 1,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            icon: Icon(Icons.search),
            splashColor: Colors.blue,
          ),
        ),
      );
  }
}
