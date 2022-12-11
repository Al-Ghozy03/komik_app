// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_app/widgets/shimmer.dart';

class LoadingRow extends StatelessWidget {
  const LoadingRow({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          width: width / 3.3,
          height: width / 3.3,
          radius: 10,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              width: width / 2,
              height: width / 16,
              radius: 100,
            ),
            SizedBox(height: 10),
            Shimmer(
              width: width / 4,
              height: width / 23,
              radius: 100,
            ),
          ],
        )
      ],
    );
  }
}
