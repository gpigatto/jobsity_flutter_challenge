import 'package:flutter/cupertino.dart';

class VSpace extends StatelessWidget {
  final double height;

  const VSpace(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HSpace extends StatelessWidget {
  final double width;

  const HSpace(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
