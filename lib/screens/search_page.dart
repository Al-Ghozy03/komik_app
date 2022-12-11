// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/services/api_service.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/models/search.dart';
import 'package:komik_app/widgets/card_row.dart';
import 'package:komik_app/widgets/loading_row.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future search;

  void onChanged(String keyword) {
    search = ApiService.search(keyword);
  }

  @override
  void initState() {
    onChanged("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: Padding(
          padding: EdgeInsets.only(
            top: 5,
            left: 7,
          ),
          child: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            elevation: 0,
            title: TextField(
              onChanged: (value) {
                setState(() {
                  search = ApiService.search(value);
                });
              },
              decoration: InputDecoration(
                  constraints: BoxConstraints.tightFor(
                      height: 46, width: Get.width / 0.75),
                  isDense: true,
                  filled: true,
                  hintText: "Search..",
                  fillColor: Color(0xff23252F),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none)),
            ),
            backgroundColor: dark,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
        child: search != null
            ? FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return _loadingSearch();
                  if (snapshot.hasError) return _loadingSearch();
                  if (snapshot.hasData) return _listBuilder(snapshot.data);
                  return _loadingSearch();
                },
                future: search,
              )
            : Text("hoho"),
      )),
    );
  }
}

Widget _listBuilder(Search data) {
  return ListView(
    children: data.data
        .map((e) => CardRow(
              data: e,
            ))
        .toList(),
  );
}

Widget _loadingSearch() {
  return ListView(
    children: List.generate(
        5,
        (index) => Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: LoadingRow(),
            )),
  );
}
