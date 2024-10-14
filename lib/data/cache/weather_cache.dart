import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

class WeatherCache {
  static Database? _database;
  static const String tableName = 'weather_cache';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'weather_cache.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            location TEXT PRIMARY KEY,
            data TEXT,
            timestamp INTEGER
          )
        ''');
      },
    );
  }

  Future<void> saveWeatherData(
      String location, Map<String, dynamic> data) async {
    final db = await database;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      tableName,
      {
        'location': location,
        'data': json.encode(data),
        'timestamp': timestamp,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Saved weather data for $location to cache',
        name: 'WeatherCache');
  }

  Future<Map<String, dynamic>?> getWeatherData(String location) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final thirtyMinutesAgo = now - (30 * 60 * 1000);

    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: 'location = ? AND timestamp > ?',
      whereArgs: [location, thirtyMinutesAgo],
    );

    if (results.isNotEmpty) {
      developer.log('Retrieved cached weather data for $location',
          name: 'WeatherCache');
      return json.decode(results.first['data']);
    } else {
      developer.log('No valid cached data found for $location',
          name: 'WeatherCache');
      return null;
    }
  }
}
