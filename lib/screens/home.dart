// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/services/api_service.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/genre_menu.dart';
import 'package:komik_app/models/recommended.dart';
import 'package:komik_app/models/terbaru.dart';
import 'package:komik_app/screens/detail_page.dart';
import 'package:komik_app/screens/search_page.dart';
import 'package:komik_app/screens/terbaru.dart';
import 'package:komik_app/widgets/card_col.dart';
import 'package:komik_app/widgets/genre_card.dart';
import 'package:komik_app/widgets/loading_col.dart';
import 'package:komik_app/widgets/shimmer.dart';
import 'package:komik_app/widgets/custom_title.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final height = Get.height;
  final width = Get.width;
  late Future recommended;
  late Future terbaru;
  late Future genre;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    terbaru = ApiService.terbaru(1);
    recommended = ApiService.recommended();
    genre = ApiService.genreMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              FutureBuilder(
                future: recommended,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return _loadingRecommended(width);
                  if (snapshot.hasError) return _loadingRecommended(width);
                  if (snapshot.hasData)
                    return _recommendedBuilder(width, snapshot.data);
                  return _loadingRecommended(width);
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(103, 0, 0, 0)),
                    child: IconButton(
                      onPressed: () => Get.to(() => SearchPage(),
                          transition: Transition.rightToLeftWithFade),
                      icon: Icon(Iconsax.search_normal_1),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 30),
            FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return _loadingGenre(width);
                  if (snapshot.hasError) return _loadingGenre(width);
                  if (snapshot.hasData)
                    return _genreBuilder(width, snapshot.data);
                  return _loadingGenre(width);
                },
                future: genre),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTitle(title: "Terbaru"),
                      TextButton(
                          onPressed: () => Get.to(() => TerbaruPage(),
                              transition: Transition.rightToLeftWithFade),
                          child: Text(
                            "See more",
                            style: TextStyle(color: blueTheme),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: terbaru,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return _loadingTerbaru(width);
                      if (snapshot.hasError) return _loadingTerbaru(width);
                      if (snapshot.hasData)
                        return _terbaruBuilder(width, snapshot.data);
                      return _loadingTerbaru(width);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

Widget _genreBuilder(widht, GenreMenu data) {
  return Container(
    height: 35,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: data.data.map((e) => GenreCard(data: e)).toList(),
    ),
  );
}

Widget _recommendedBuilder(width, Recommended data) {
  return CarouselSlider.builder(
      itemCount: data.data.length,
      itemBuilder: (context, i, realIndex) => OpenContainer(
            openElevation: 0,
            closedElevation: 0,
            closedBuilder: (context, action) => Container(
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(data.data[i].thumbnail),
                      fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(19, 24, 25, 32), dark])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      data.data[i].type.toLowerCase() == "manhwa"
                          ? "assets/images/korsel.png"
                          : data.data[i].type.toLowerCase() == "manhua"
                              ? "assets/images/china.png"
                              : "assets/images/japan.png",
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.data[i].title,
                                style: TextStyle(
                                    fontFamily: "bold", fontSize: width / 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(data.data[i].chapter),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.star1,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(data.data[i].rating)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            openBuilder: (context, action) => DetailPage(
              href: data.data[i].href,
              thumbnail: data.data[i].thumbnail,
            ),
          ),
      options: CarouselOptions(height: width / 1.15, viewportFraction: 1));
}

Widget _terbaruBuilder(width, Terbaru data) {
  return StaggeredGrid.count(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 20,
    children: data.data.map((e) => CardCol(data: e)).toList(),
  );
}

Widget _loadingGenre(width) {
  return Container(
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
              )),
    ),
  );
}

Widget _loadingTerbaru(width) {
  return StaggeredGrid.count(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 20,
    children: List.generate(7, (index) => LoadingCol()),
  );
}

Widget _loadingRecommended(width) {
  return Shimmer(width: width, height: width / 1.15);
}
