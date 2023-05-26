// ignore_for_file: depend_on_referenced_packages
import 'package:komik_app/models/favorite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqliteService {
  static String dbName = "komik.db";

  static Future<Database> createFavorite() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE IF NOT EXISTS favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, thumbnail TEXT NOT NULL, rating TEXT NOT NULL, href TEXT NOT NULL, type TEXT NOT NULL, genre TEXT NOT NULL)"),
    );
  }

  static Future insertFavorite(Map<String, dynamic> values) async {
    final db = await createFavorite();
    await db.insert("favorite", values);
  }

  static Future readfavorite() async {
    final db = await createFavorite();
    final res = await db.query("favorite");
   return res.map((e) => FavoriteModel.fromJson(e)).toList();
  }
}
