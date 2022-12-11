// To parse required this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
    Search({
        required this.status,
        required this.data,
    });

    String status;
    List<Datum> data;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
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
        required this.type,
        required this.chapter,
        required this.rating,
        required this.href,
        required this.thumbnail,
    });

    String title;
    String type;
    String chapter;
    String rating;
    String href;
    String thumbnail;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        type: json["type"],
        chapter: json["chapter"],
        rating: json["rating"],
        href: json["href"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "chapter": chapter,
        "rating": rating,
        "href": href,
        "thumbnail": thumbnail,
    };
}
