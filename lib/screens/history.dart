// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:komik_app/models/history_model.dart';
import 'package:komik_app/services/sqlite_service.dart';
import 'package:komik_app/widgets/card_row.dart';
import 'package:komik_app/widgets/custom_title.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future history;

  @override
  void initState() {
    history = SqliteService.readHistory();
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
              CustomTitle(title: "History"),
              FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text("loading");
                  if (snapshot.hasError) return Text("error");
                  if (snapshot.hasData) return _list(snapshot.data);
                  return Text("error");
                },
                future: history,
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _list(List<HistoryModel> data) {
    return Column(
      children: data
          .map((e) => Dismissible(
              onDismissed: (direction) {
                SqliteService.delete("history", "href", e.href);
                SqliteService.delete("chapter_history", "href_id", e.href);
              },
              key: UniqueKey(),
              child: CardRow(
                title: e.title,
                href: e.href,
                rating: e.rating,
                thumbnail: e.thumbnail,
                type: e.type,
                chapter: e.chapter,
              )))
          .toList(),
    );
  }
}
