// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
    int id;
    String title;
    String thumbnail;
    String rating;
    String href;
    String type;
    String chapter;
    DateTime updatedAt;

    HistoryModel({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.rating,
        required this.href,
        required this.type,
        required this.chapter,
        required this.updatedAt,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        rating: json["rating"],
        href: json["href"],
        type: json["type"],
        chapter: json["chapter"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "rating": rating,
        "href": href,
        "type": type,
        "chapter": chapter,
        "updated_at": updatedAt.toIso8601String(),
    };
}
