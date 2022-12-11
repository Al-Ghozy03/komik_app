// To parse required this JSON data, do
//
//     final terbaru = terbaruFromJson(jsonString);

import 'dart:convert';

Terbaru terbaruFromJson(String str) => Terbaru.fromJson(json.decode(str));

String terbaruToJson(Terbaru data) => json.encode(data.toJson());

class Terbaru {
    Terbaru({
        required this.status,
        required this.currentPage,
        required this.lengthPage,
        required this.data,
    });

    String status;
    int currentPage;
    int lengthPage;
    List<Datum> data;

    factory Terbaru.fromJson(Map<String, dynamic> json) => Terbaru(
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
        required this.href,
        required this.thumbnail,
        required this.type,
        required this.chapter,
        required this.rating,
    });

    String title;
    String href;
    String thumbnail;
    String type;
    String chapter;
    String rating;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
        thumbnail: json["thumbnail"],
        type: json["type"],
        chapter: json["chapter"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "thumbnail": thumbnail,
        "type": type,
        "chapter": chapter,
        "rating": rating,
    };
}
