// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTitle extends StatelessWidget {
  String title;
  CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontFamily: "semibold", fontSize: Get.width / 15),
    );
  }
}
