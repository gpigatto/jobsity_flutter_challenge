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

  int _flex1 = 0;
  int _flex2 = 3;
  int _flex3 = 0;

  @override
  Widget build(BuildContext context) {
    final _logo = SvgImages.jobsityLogo;
    final _duration = Duration(milliseconds: 800);
    final _curve = Curves.easeOutQuad;
    final _opacityCurve = Curves.easeInExpo;
    final _padding = 32.0;

    double width = MediaQuery.of(context).size.width;

    var width1 = (_flex1 * width) / (_flex1 + _flex2 + _flex3);
    var width2 = (_flex2 * width) / (_flex1 + _flex2 + _flex3);
    var width3 = (_flex3 * width) / (_flex1 + _flex2 + _flex3);

    return BlocListener<AnimationCubit, bool>(
      listener: (context, state) {
        setState(() {
          inAnimation = state;
          _flex1 = 1;
          _flex3 = 1;
        });
      },
      child: Row(
        children: [
          AnimatedOpacity(
            opacity: inAnimation ? 0 : 1,
            curve: _opacityCurve,
            duration: _duration,
            child: AnimatedContainer(
              duration: _duration,
              curve: _curve,
              width: width1,
              alignment: Alignment.center,
              child: _menuButton(),
            ),
          ),
          AnimatedContainer(
            duration: _duration,
            curve: _curve,
            width: width2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: Container(
                height: double.infinity,
                child: SvgPicture.asset(
                  _logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: inAnimation ? 0 : 1,
            curve: _opacityCurve,
            duration: _duration,
            child: AnimatedContainer(
              duration: _duration,
              curve: _curve,
              width: width3,
              alignment: Alignment.center,
              child: _searchButton(),
            ),
          ),
        ],
      ),
    );
  }

  _menuButton() {
    return Material(
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
    );
  }

  _searchButton() {
    return Material(
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
    );
  }
}
