// To parse this JSON data, do
//
//     final chapterHistoryModel = chapterHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ChapterHistoryModel> chapterHistoryModelFromJson(String str) => List<ChapterHistoryModel>.from(json.decode(str).map((x) => ChapterHistoryModel.fromJson(x)));

String chapterHistoryModelToJson(List<ChapterHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterHistoryModel {
    int id;
    String hrefId;
    String title;
    String href;
    DateTime updateAt;

    ChapterHistoryModel({
        required this.id,
        required this.hrefId,
        required this.title,
        required this.href,
        required this.updateAt,
    });

    factory ChapterHistoryModel.fromJson(Map<String, dynamic> json) => ChapterHistoryModel(
        id: json["id"],
        hrefId: json["href_id"],
        title: json["title"],
        href: json["href"],
        updateAt: DateTime.parse(json["update_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "href_id": hrefId,
        "title": title,
        "href": href,
        "update_at": updateAt.toIso8601String(),
    };
}
