// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/screens/detail_page.dart';

class CardCol extends StatefulWidget {
  final data;
  CardCol({required this.data});
  @override
  State<CardCol> createState() => _CardColState();
}

class _CardColState extends State<CardCol> {
  @override
  Widget build(BuildContext context) {
    final width = Get.height;
    return OpenContainer(
      closedColor: dark,
      openColor: dark,
      closedElevation: 0,
      openElevation: 1,
      openBuilder: (context, action) =>
          DetailPage(thumbnail: widget.data.thumbnail, href: widget.data.href),
      closedBuilder: (context, action) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: width / 3.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    widget.data.thumbnail,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Color.fromARGB(144, 0, 0, 0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        color: Colors.yellow,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.data.rating,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(height: 5),
          Text(
            widget.data.chapter,
            style: TextStyle(
              fontFamily: "semibold",
              fontSize: width / 40,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.data.chapter,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
