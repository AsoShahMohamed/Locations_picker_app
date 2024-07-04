import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import 'package:sqflite/sqlite_api.dart';

class SqlLite {
  static Future<Database> getConnectionInstance() async {
    final dbPath = await sql.getDatabasesPath();

    return await sql.openDatabase(path.join(dbPath, 'places_app.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places  (id TEXT PRIMARY KEY, title TEXT , image TEXT, latitude REAL, longitude REAL, address TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbConnection = await SqlLite.getConnectionInstance();

    final val = await dbConnection.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchRecords(String table) async {
    final dbConnection = await SqlLite.getConnectionInstance();

    return await dbConnection.rawQuery('Select * from $table');
  }
}
