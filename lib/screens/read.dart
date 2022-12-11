// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/read.dart';
import 'package:komik_app/services/api_service.dart';

class Read extends StatefulWidget {
  String href;
  Read({super.key, required this.href});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  late Future read;
  ScrollController scrollController = ScrollController();
  bool showFloatButton = false;
  @override
  void initState() {
    read = ApiService.read(widget.href);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !showFloatButton
          ? Container()
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: blueTheme,
              child: Icon(
                Iconsax.arrow_up_2,
                color: Colors.white,
              ),
            ),
      appBar: PreferredSize(
        preferredSize: Size(0, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            backgroundColor: dark,
          ),
        ),
      ),
      body: SafeArea(
          child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          setState(() {
            if (notification.metrics.pixels > 2177.974055120945) {
              showFloatButton = true;
            } else {
              showFloatButton = false;
            }
          });
          // print(notification.metrics.pixels);
          return true;
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: FutureBuilder(
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
              )),
        ),
      )),
    );
  }

  Widget _chapterBuilder(ReadModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.data[0].title,
                style: TextStyle(fontFamily: "bold", fontSize: Get.width / 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
        Column(
          children: data.data[0].panel
              .map((e) => CachedNetworkImage(
                    imageUrl: e,
                    placeholder: (context, url) => Text("loading"),
                    filterQuality: FilterQuality.low,
                  ))
              .toList(),
        )
      ],
    );
  }
}
