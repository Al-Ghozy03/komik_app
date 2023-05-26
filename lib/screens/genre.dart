// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, must_be_immutable, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll/infinite_scroll.dart';
import 'package:komik_app/services/api_service.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/genre_model.dart';
import 'package:komik_app/widgets/card_row.dart';
import 'package:komik_app/widgets/loading_row.dart';

class Genre extends StatefulWidget {
  String href;
  String title;
  Genre({super.key, required this.href, required this.title});

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  late Future genre;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool hasLoading = false;
  bool isBottom = false;
  bool isLoading = false;

  FutureOr refetch(GenreModel data, page) {
    setState(() {
      isLoading = true;
      ApiService.genre(widget.href, page).then((value) {
        data.currentPage = value.currentPage;
        isLoading = false;
        value.data.map((e) {
          data.data.add(e);
          isBottom = false;
        }).toList();
      });
    });
  }

  @override
  void initState() {
    genre = ApiService.genre(widget.href, page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 50),
        child: Padding(
          padding: EdgeInsets.only(
            top: 5,
            left: 7,
          ),
          child: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            elevation: 0,
            title: Text(
              widget.title,
              style: TextStyle(fontFamily: "semibold"),
            ),
            backgroundColor: dark,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return _loading();
            if (snapshot.hasError) return _loading();
            if (snapshot.hasData) return _listBuilder(snapshot.data);
            return _loading();
          },
          future: genre,
        ),
      )),
    );
  }

  bool everythingLoaded = false;

  Widget _listBuilder(GenreModel data) {
    return InfiniteScrollList(
      onLoadingStart: (page) {
        if (data.currentPage == data.lengthPage) {
          setState(() {
            everythingLoaded = true;
          });
        }
        refetch(data, page);
      },
      everythingLoaded: everythingLoaded,
      children: data.data
          .map((e) => CardRow(
                title: e.title,
                href: e.href,
                rating: e.rating,
                thumbnail: e.thumbnail,
                type: e.type,
                chapter: e.chapter,
              ))
          .toList(),
    );
  }

  Widget _loading() {
    return Container(
      height: Get.height,
      child: ListView(
        children: List.generate(
            5,
            (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: LoadingRow(),
                )),
      ),
    );
  }
}
