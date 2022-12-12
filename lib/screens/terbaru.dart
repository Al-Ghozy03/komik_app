// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll/infinite_scroll.dart';
import 'package:komik_app/services/api_service.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/terbaru.dart';
import 'package:komik_app/widgets/card_col.dart';
import 'package:komik_app/widgets/loading_row.dart';

class TerbaruPage extends StatefulWidget {
  TerbaruPage({super.key});

  @override
  State<TerbaruPage> createState() => _TerbaruPageState();
}

class _TerbaruPageState extends State<TerbaruPage> {
  late Future genre;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool hasLoading = false;
  bool isBottom = false;
  bool isLoading = false;

  FutureOr refetch(Terbaru data, page) {
    setState(() {
      isLoading = true;
      ApiService.terbaru(page).then((value) {
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
    genre = ApiService.terbaru(page);
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
              "Terbaru",
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

  Widget _listBuilder(Terbaru data) {
    return InfiniteScrollList(
      onLoadingStart: (page) {
        if (data.currentPage == data.lengthPage) {
          setState(() {
            everythingLoaded = true;
          });
        }
        refetch(data, page + 1);
      },
      everythingLoaded: everythingLoaded,
      children: [
        StaggeredGrid.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: data.data.map((e) => CardCol(data: e)).toList())
      ],
    );
  }

  Widget _loading() {
    return ListView(
      children: List.generate(
          5,
          (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: LoadingRow(),
              )),
    );
  }
}
