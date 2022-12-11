import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:komik_app/models/detail.dart';
import 'package:komik_app/models/genre_menu.dart';
import 'package:komik_app/models/genre_model.dart';
import 'package:komik_app/models/read.dart';
import 'package:komik_app/models/recommended.dart';
import 'package:komik_app/models/search.dart';
import 'package:komik_app/models/terbaru.dart';

class ApiService {
  static String baseUrl = "https://komikcast-api.up.railway.app";

  static Future read(String href) async {
    final res = await http.get(Uri.parse("$baseUrl/read$href"));
    if (res.statusCode == 200) {
      return readModelFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future genre(String href, int page) async {
    final res = await http.get(Uri.parse("$baseUrl/genre$href?page=$page"));
    if (res.statusCode == 200) {
      return genreModelFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future detail(String href) async {
    final res = await http.get(Uri.parse("$baseUrl/detail$href"));
    if (res.statusCode == 200) {
      return detailModelFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future search(String keyword) async {
    final res = await http.get(Uri.parse("$baseUrl/search?keyword=$keyword"));
    if (res.statusCode == 200) {
      return searchFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future genreMenu() async {
    final res = await http.get(Uri.parse("$baseUrl/genre"));
    if (res.statusCode == 200) {
      return genreMenuFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future terbaru(int page) async {
    final res = await http.get(Uri.parse("$baseUrl/terbaru?page=$page"));
    if (res.statusCode == 200) {
      return terbaruFromJson(res.body);
    } else {
      return false;
    }
  }

  static Future recommended() async {
    final res = await http.get(Uri.parse("$baseUrl/recommended"));
    if (res.statusCode == 200) {
      return recommendedFromJson(res.body);
    } else {
      return false;
    }
  }
}
