// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/screens/detail_page.dart';

class CardRow extends StatefulWidget {
  String title;
  String thumbnail;
  String rating;
  String href;
  String type;
  String? chapter;
  String? genre;
  CardRow(
      {super.key,
      required this.title,
      required this.thumbnail,
      required this.rating,
      required this.type,
      required this.href,
      this.chapter,
      this.genre});

  @override
  State<CardRow> createState() => _CardRowState();
}

class _CardRowState extends State<CardRow> {
  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return OpenContainer(
      closedColor: dark,
      openColor: dark,
      openElevation: 0,
      closedElevation: 0,
      closedBuilder: (context, action) => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width / 3.3,
              width: width / 3.3,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.thumbnail),
                      fit: BoxFit.cover)),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                      widget.type.toString().toLowerCase() == "manga"
                          ? "assets/images/japan.png"
                          : widget.type.toString().toLowerCase() == "manhwa"
                              ? "assets/images/korsel.png"
                              : "assets/images/china.png",
                      height: 15)),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontFamily: "semibold", fontSize: width / 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    widget.chapter != null
                        ? widget.chapter.toString()
                        : widget.genre.toString(),
                    style: TextStyle(fontSize: width / 30),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        size: width / 23,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 3),
                      Text(
                        widget.rating,
                        style: TextStyle(fontSize: width / 32),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      openBuilder: (context, action) =>
          DetailPage(thumbnail: widget.thumbnail, href: widget.href),
    );
  }
}
