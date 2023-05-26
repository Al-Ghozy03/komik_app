// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteModel> favoriteModelFromJson(String str) => List<FavoriteModel>.from(json.decode(str).map((x) => FavoriteModel.fromJson(x)));

String favoriteModelToJson(List<FavoriteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
    String title;
    String thumbnail;
    String rating;
    String href;
    String type;
    String genre;

    FavoriteModel({
        required this.title,
        required this.thumbnail,
        required this.rating,
        required this.href,
        required this.type,
        required this.genre,
    });

    factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        title: json["title"],
        thumbnail: json["thumbnail"],
        rating: json["rating"],
        href: json["href"],
        type: json["type"],
        genre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "rating": rating,
        "href": href,
        "type": type,
        "genre": genre,
    };
}
