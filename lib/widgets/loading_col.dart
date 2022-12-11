// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_app/widgets/shimmer.dart';

class LoadingCol extends StatelessWidget {
  const LoadingCol({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          width: width,
          height: width / 2,
          radius: 10,
        ),
        SizedBox(height: 7),
        Shimmer(
          width: width / 3.2,
          height: width / 20,
          radius: 100,
        ),
      ],
    );
  }
}
