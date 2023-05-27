// ignore_for_file: depend_on_referenced_packages
import 'package:komik_app/models/chapter_history_model.dart';
import 'package:komik_app/models/favorite_model.dart';
import 'package:komik_app/models/history_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqliteService {
  static String dbName = "comic.db";

  // create table
  static Future<Database> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, thumbnail TEXT NOT NULL, rating TEXT NOT NULL, href TEXT NOT NULL, type TEXT NOT NULL, genre TEXT NOT NULL)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS history (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, thumbnail TEXT NOT NULL, rating TEXT NOT NULL, href TEXT NOT NULL, type TEXT NOT NULL, chapter TEXT NOT NULL, updated_at TEXT NOT NULL)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS chapter_history (id INTEGER PRIMARY KEY AUTOINCREMENT, href_id TEXT NOT NULL, title TEXT NOT NULL, href TEXT NOT NULL, update_at TEXT NOT NULL)");
      },
    );
  }

  // create table

  static Future insert(String table, Map<String, dynamic> values) async {
    final db = await initDB();
    await db.insert(table, values);
  }

  static Future readFavorite() async {
    final db = await initDB();
    final res = await db.query("favorite", orderBy: "id DESC");
    return res.map((e) => FavoriteModel.fromJson(e)).toList();
  }

  static Future readHistory() async {
    final db = await initDB();
    final res = await db.query("history", orderBy: "updated_at DESC");
    return res.map((e) => HistoryModel.fromJson(e)).toList();
  }
  static Future readChapterHistory(String hrefId) async {
    final db = await initDB();
    final res = await db.query("chapter_history",where: "href_id = '$hrefId'");
    return res.map((e) => ChapterHistoryModel.fromJson(e)).toList();
  }

  static Future<int> findOne(String table, String column, String value) async {
    final db = await initDB();
    final res = await db.query(table, where: "$column = '$value'");
    return res.length;
  }

  static Future update(
      String name, Map<String, dynamic> data, String column,String value) async {
    final db = await initDB();
    await db.update(name, data, where: "$column = '$value'");
  }

  static Future delete(String name, String column ,String href) async {
    final db = await initDB();
    await db.delete(name, where: "$column = '$href'");
  }
}
