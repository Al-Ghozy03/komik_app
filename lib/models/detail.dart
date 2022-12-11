// To parse required this JSON data, do
//
//     final detailModel = detailModelFromJson(jsonString);

import 'dart:convert';

DetailModel detailModelFromJson(String str) =>
    DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
  DetailModel({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.title,
    required this.rating,
    required this.status,
    required this.type,
    required this.released,
    required this.author,
    required this.genre,
    required this.description,
    this.thumbnail,
    required this.chapter,
  });

  String title;
  String rating;
  String status;
  String type;
  String released;
  String author;
  List<Genre> genre;
  String description;
  String? thumbnail;
  List<Chapter> chapter;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        rating: json["rating"],
        status: json["status"],
        type: json["type"],
        released: json["released"],
        author: json["author"],
        genre: List<Genre>.from(json["genre"].map((x) => Genre.fromJson(x))),
        description: json["description"],
        thumbnail: json["thumbnail"],
        chapter:
            List<Chapter>.from(json["chapter"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rating": rating,
        "status": status,
        "type": type,
        "released": released,
        "author": author,
        "genre": List<dynamic>.from(genre.map((x) => x.toJson())),
        "description": description,
        "thumbnail": thumbnail,
        "chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
      };
}

class Chapter {
  Chapter({
    required this.title,
    required this.href,
    required this.date,
  });

  String title;
  String href;
  String date;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: json["title"],
        href: json["href"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "date": date,
      };
}

class Genre {
  Genre({
    required this.title,
    required this.href,
  });

  String title;
  String href;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        title: json["title"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
      };
}
