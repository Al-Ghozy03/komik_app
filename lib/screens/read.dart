// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/detail.dart';
import 'package:komik_app/models/read.dart';
import 'package:komik_app/services/api_service.dart';

class Read extends StatefulWidget {
  String href;
  List<Chapter> chapter;
  int index;
  String hrefKomik;
  Read(
      {super.key,
      required this.href,
      required this.chapter,
      required this.hrefKomik,
      required this.index});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  late Future read;
  ScrollController scrollController = ScrollController();
  bool showFloatButton = false;
  int currentIndex = 0;

  void nextChapter() {
    if (currentIndex == 0) return;
    setState(() {
      currentIndex -= 1;
    });
    Get.off(
        () => Read(
            href: widget.chapter[currentIndex].href,
            chapter: widget.chapter,
            hrefKomik: widget.hrefKomik,
            index: currentIndex),
        transition: Transition.rightToLeftWithFade,
        preventDuplicates: false);
  }

  void prevChapter() {
    if (currentIndex == widget.chapter.length - 1) return;
    setState(() {
      currentIndex += 1;
    });
    Get.off(
        () => Read(
            href: widget.chapter[currentIndex].href,
            chapter: widget.chapter,
            hrefKomik: widget.hrefKomik,
            index: currentIndex),
        transition: Transition.leftToRightWithFade,
        preventDuplicates: false);
  }

  FutureOr refetch() {
    read = ApiService.read(widget.chapter[currentIndex].href);
  }

  @override
  void initState() {
    currentIndex = widget.index;
    read = ApiService.read(widget.href);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !showFloatButton
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn);
              },
              backgroundColor: blueTheme,
              child: Icon(
                Iconsax.arrow_up_2,
                color: Colors.white,
              ),
            ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasError)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasData) return _chapterBuilder(snapshot.data);
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: read,
      ),
    );
  }

  Widget _buttonAction(width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentIndex != widget.chapter.length - 1)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: blueTheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                onPressed: () => prevChapter(),
                icon: Icon(
                  Iconsax.arrow_left_2,
                  size: width / 20,
                ),
                label: Text(
                  "Prev",
                  style: TextStyle(fontSize: width / 25),
                )),
          if (currentIndex != 0)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: blueTheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                onPressed: () => nextChapter(),
                icon: Text(
                  "Next",
                  style: TextStyle(fontSize: width / 25),
                ),
                label: Transform.rotate(
                  angle: 355,
                  child: Icon(
                    Iconsax.arrow_left_2,
                    size: width / 20,
                  ),
                ))
        ],
      ),
    );
  }

  Widget _chapterBuilder(ReadModel data) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        setState(() {
          if (notification.metrics.pixels > 2177.974055120945) {
            showFloatButton = true;
          } else {
            showFloatButton = false;
          }
        });
        return true;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: dark,
            leading: IconButton(
                onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            pinned: true,
            // snap: true,
            // floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                data.data[0].title,
                style: TextStyle(fontFamily: "bold", fontSize: Get.width / 20),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
            if (i == 0)
              return Column(
                children: [
                  _buttonAction(Get.width),
                  SizedBox(height: 20),
                  CachedNetworkImage(
                    imageUrl: data.data[0].panel[i],
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                  )
                ],
              );
            if (i == data.data[0].panel.length - 1)
              return Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: data.data[0].panel[i],
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buttonAction(Get.width),
                  SizedBox(height: 80),
                ],
              );
            return CachedNetworkImage(
              imageUrl: data.data[0].panel[i],
              progressIndicatorBuilder: (context, url, progress) => Container(
                margin: EdgeInsets.symmetric(vertical: 45),
                child: Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            );
          }, childCount: data.data[0].panel.length))
        ],
      ),
    );
  }
}
