// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  final width;
  final height;
  double? radius;
  Shimmer({super.key, required this.width, required this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: width,
      height: height,
      radius: radius ?? 0,
      baseColor: Color(0xff23252F),
      highlightColor: Color(0xff343645),
    );
  }
}
