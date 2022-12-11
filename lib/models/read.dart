// To parse required this JSON data, do
//
//     final readModel = readModelFromJson(jsonString);

import 'dart:convert';

ReadModel readModelFromJson(String str) => ReadModel.fromJson(json.decode(str));

String readModelToJson(ReadModel data) => json.encode(data.toJson());

class ReadModel {
    ReadModel({
        required this.status,
        required this.data,
    });

    String status;
    List<Datum> data;

    factory ReadModel.fromJson(Map<String, dynamic> json) => ReadModel(
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
        required this.panel,
    });

    String title;
    List<String> panel;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        panel: List<String>.from(json["panel"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "panel": List<dynamic>.from(panel.map((x) => x)),
    };
}
