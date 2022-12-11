// To parse required this JSON data, do
//
//     final genreMenu = genreMenuFromJson(jsonString);

import 'dart:convert';

GenreMenu genreMenuFromJson(String str) => GenreMenu.fromJson(json.decode(str));

String genreMenuToJson(GenreMenu data) => json.encode(data.toJson());

class GenreMenu {
    GenreMenu({
        required this.status,
        required this.data,
    });

    String status;
    List<Datum> data;

    factory GenreMenu.fromJson(Map<String, dynamic> json) => GenreMenu(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.title,
        required this.href,
    });

    String title;
    String href;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
    };
}
