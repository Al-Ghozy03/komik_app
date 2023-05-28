// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:komik_app/models/favorite_model.dart';
import 'package:komik_app/services/sqlite_service.dart';
import 'package:komik_app/widgets/card_row.dart';
import 'package:komik_app/widgets/custom_title.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Future favorite;
  @override
  void initState() {
    favorite = SqliteService.readFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(title: "Favorite"),
              FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text("loading");
                  if (snapshot.hasError) return Text("error");
                  if (snapshot.hasData) return _list(snapshot.data);
                  return Text("error");
                },
                future: favorite,
              )
            ],
          ),
        ),
      )),
    );
  }
}

Widget _list(List<FavoriteModel> data) {
  return Column(
    children: data
        .map((e) => Dismissible(
            onDismissed: (direction) {
              SqliteService.delete("favorite", "href", e.href);
            },
            key: UniqueKey(),
            child: CardRow(
              title: e.title,
              href: e.href,
              rating: e.rating,
              thumbnail: e.thumbnail,
              type: e.type,
              genre: e.genre,
            )))
        .toList(),
  );
}
