// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/screens/read.dart';
import 'package:komik_app/services/api_service.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/detail.dart';
import 'package:komik_app/services/sqlite_service.dart';
import 'package:komik_app/widgets/genre_card.dart';
import 'package:komik_app/widgets/shimmer.dart';
import 'package:komik_app/widgets/custom_title.dart';

class DetailPage extends StatefulWidget {
  String thumbnail;
  String href;
  DetailPage({super.key, required this.thumbnail, required this.href});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future detail;
  @override
  void initState() {
    detail = ApiService.detail(widget.href);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: width / 1.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.thumbnail),
                          fit: BoxFit.cover)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromARGB(19, 24, 25, 32), dark])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(103, 0, 0, 0)),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Iconsax.arrow_left),
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: FutureBuilder(
                future: detail,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return _loading(width);
                  if (snapshot.hasError) return _loading(width);
                  if (snapshot.hasData)
                    return _detailBuilder(width, snapshot.data);
                  return _loading(width);
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _detailBuilder(width, DetailModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.data.title,
                style: TextStyle(fontFamily: "bold", fontSize: width / 15),
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(0xff23252F),
              child: IconButton(
                  onPressed: () async {
                    await SqliteService.insertFavorite({
                      "title": data.data.title,
                      "thumbnail": data.data.thumbnail,
                      "rating": data.data.rating,
                      "href": widget.href,
                      "type": data.data.type,
                      "genre": data.data.genre.map((e) => e.title).join(", "),
                    });
                  },
                  icon: Icon(
                    Iconsax.heart_add5,
                    color: Colors.red,
                  )),
            ),
          ],
        ),
        SizedBox(height: 10),
        StaggeredGrid.count(
          crossAxisCount: 2,
          children: [
            _info("Status", data.data.status),
            _info("Type", data.data.type),
            _info("Released", data.data.released),
            _info("Author", data.data.author),
          ],
        ),
        SizedBox(height: 10),
        CustomTitle(title: "Genre"),
        SizedBox(height: 7),
        Container(
          height: 35,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  data.data.genre.map((e) => GenreCard(data: e)).toList()),
        ),
        if (data.data.description != "") SizedBox(height: 10),
        if (data.data.description != "") CustomTitle(title: "Sinopsis"),
        if (data.data.description != "") SizedBox(height: 5),
        if (data.data.description != "") Text(data.data.description),
        SizedBox(height: 10),
        CustomTitle(title: "Chapter"),
        SizedBox(height: 7),
        StaggeredGrid.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          children: data.data.chapter
              .asMap()
              .entries
              .map((e) => _chapter(width, e.value, e.key, data.data.chapter))
              .toList(),
        )
      ],
    );
  }

  Widget _loading(width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer(
              width: width / 1.5,
              height: width / 13,
              radius: 100,
            ),
            Shimmer(
              width: width / 10,
              height: width / 10,
              radius: 100,
            )
          ],
        ),
        SizedBox(height: 20),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            Shimmer(
              width: width,
              height: width / 20,
              radius: 100,
            ),
            Shimmer(
              width: width,
              height: width / 20,
              radius: 100,
            ),
            Shimmer(
              width: width,
              height: width / 20,
              radius: 100,
            ),
            Shimmer(
              width: width,
              height: width / 20,
              radius: 100,
            ),
          ],
        ),
        SizedBox(height: 20),
        Shimmer(
          width: width / 2.5,
          height: width / 15,
          radius: 100,
        ),
        SizedBox(height: 10),
        Container(
          height: 35,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Shimmer(
                    width: width / 4,
                    height: width / 10,
                    radius: 100,
                  ),
                ),
              )),
        ),
        SizedBox(height: 20),
        Shimmer(
          width: width / 2.5,
          height: width / 15,
          radius: 100,
        ),
        SizedBox(height: 10),
        Shimmer(
          width: width,
          height: width / 20,
          radius: 100,
        ),
        SizedBox(height: 10),
        Shimmer(
          width: width / 1.4,
          height: width / 20,
          radius: 100,
        ),
        SizedBox(height: 20),
        Shimmer(
          width: width / 2.5,
          height: width / 15,
          radius: 100,
        ),
        SizedBox(height: 10),
        StaggeredGrid.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          children: List.generate(
              5,
              (index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Shimmer(
                      width: width,
                      height: width / 9,
                      radius: 10,
                    ),
                  )),
        )
      ],
    );
  }

  Widget _chapter(width, data, int i, List<Chapter> chapter) {
    return InkWell(
      onTap: () => Get.to(
          () => Read(
                href: data.href,
                chapter: chapter,
                hrefKomik: widget.href,
                index: i,
              ),
          transition: Transition.rightToLeftWithFade,
          preventDuplicates: false),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xff23252F), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.title),
            Text(
              data.date,
              style: TextStyle(fontSize: width / 35, color: Color(0xff6B6E7D)),
            )
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return RichText(
        text: TextSpan(
            style:
                TextStyle(fontFamily: "montserrat", fontSize: Get.width / 27),
            children: [
          TextSpan(text: "$title : ", style: TextStyle(fontFamily: "semibold")),
          TextSpan(text: value)
        ]));
  }
}
