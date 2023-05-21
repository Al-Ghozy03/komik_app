// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_app/screens/genre.dart';

class GenreCard extends StatefulWidget {
  final data;
  GenreCard({super.key, required this.data});

  @override
  State<GenreCard> createState() => _GenreCardState();
}

class _GenreCardState extends State<GenreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 10),
      child: ElevatedButton(
          onPressed: () {
            Get.to(
                () => Genre(
                      href: widget.data.href,
                      title: widget.data.title,
                    ),
                transition: Transition.rightToLeftWithFade);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff23252F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          child: Text(widget.data.title)),
    );
  }
}
