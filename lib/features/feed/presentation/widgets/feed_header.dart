import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsity_flutter_challenge/features/menu/presentation/pages/menu.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/pages/search.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/widgets/search_header.dart';
import 'package:jobsity_flutter_challenge/shared/bloc/animation_cubit.dart';
import 'package:jobsity_flutter_challenge/shared/svg_images.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';

class FeedHeader extends StatefulWidget {
  @override
  _FeedHeaderState createState() => _FeedHeaderState();
}

class _FeedHeaderState extends State<FeedHeader> {
  bool inAnimation = true;

  @override
  Widget build(BuildContext context) {
    final _horizontalPadding = 40.0;

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
          children: [
            _menuButton(),
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                child: SvgPicture.asset(
                  _logo,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            _searchButton()
          ],
        ),
      ),
    );
  }

  _menuButton() {
    if (inAnimation)
      return SizedBox();
    else
      return Expanded(
        flex: 1,
        child: Material(
          color: Colors.transparent,
          child: Button(
            icon: Icons.segment,
            fuction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Menu(),
                ),
              );
            },
          ),
        ),
      );
  }

  _searchButton() {
    if (inAnimation)
      return SizedBox();
    else
      return Expanded(
        flex: 1,
        child: Material(
          color: Colors.transparent,
          child: Button(
            icon: Icons.search,
            fuction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
          ),
        ),
      );
  }
}
