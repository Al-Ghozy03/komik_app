import 'dart:convert';

Recommended recommendedFromJson(String str) => Recommended.fromJson(json.decode(str));

String recommendedToJson(Recommended data) => json.encode(data.toJson());

class Recommended {
    Recommended({
        required this.status,
        required this.data,
    });

    String status;
    List<Datum> data;

    factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
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
        required this.rating,
        required this.chapter,
        required this.type,
        required this.thumbnail,
    });

    String title;
    String href;
    String rating;
    String chapter;
    String type;
    String thumbnail;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        href: json["href"],
        rating: json["rating"],
        chapter: json["chapter"],
        type: json["type"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
        "rating": rating,
        "chapter": chapter,
        "type": type,
        "thumbnail": thumbnail,
    };
}
