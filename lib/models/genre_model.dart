// To parse required this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

GenreModel genreModelFromJson(String str) => GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
    GenreModel({
        required this.status,
        required this.currentPage,
        required this.lengthPage,
        required this.data,
    });

    String status;
    int currentPage;
    int lengthPage;
    List<Datum> data;

    factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        status: json["status"],
        currentPage: json["current_page"],
        lengthPage: json["length_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "current_page": currentPage,
        "length_page": lengthPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.title,
        required this.chapter,
        required this.type,
        required this.href,
        required this.rating,
        required this.thumbnail,
    });

    String title;
    String chapter;
    String type;
    String href;
    String rating;
    String thumbnail;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        chapter: json["chapter"],
        type: json["type"],
        href: json["href"],
        rating: json["rating"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "chapter": chapter,
        "type": type,
        "href": href,
        "rating": rating,
        "thumbnail": thumbnail,
    };
}
