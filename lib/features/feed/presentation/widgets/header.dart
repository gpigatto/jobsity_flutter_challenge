import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsity_flutter_challenge/shared/svg_images.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: const Text('AH'),
                backgroundColor: Theme.of(context).accentColor,
                tooltip: 'AH',
                mini: true,
              ),
              Container(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset(SvgImages.jobsityLogo)),
              ClipOval(
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.search),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
