import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant/restaurants_result.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal() {
    _instance = this;
  }

  factory DatabaseService() => _instance ?? DatabaseService._internal();

  Future<Database> initDatabase() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE favorites (id TEXT PRIMARY KEY, name TEXT, description TEXT, city TEXT, pictureId TEXT, rating REAL)");
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<void> insertFavorites(RestaurantDetail restaurant) async {
    final db = await database;
    await db!.insert('favorites', restaurant.toJson());
  }

  Future<List<Restaurant>> getFavoriteList() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query('favorites');

    return result.map((data) => Restaurant.fromJson(data)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db!.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
