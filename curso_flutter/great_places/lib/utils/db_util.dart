import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

abstract class DbUtil {

  static sql.Database _sqflite;

  static const databaseName = 'places.db';

  static const tableName = 'places';

  static Future<void> initializeDatabase() async {
    final dbPath = await sql.getDatabasesPath();

    _sqflite = await sql.openDatabase(
      path.join(dbPath, databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName (id TEXT PRIMARY KEY, title TEXT, image TEXT,'
            ' latitude REAL, longitude REAL, address TEXT)'
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, dynamic> data, {String table = tableName}) async {
    await _sqflite.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData({String table = tableName}) async {
    return _sqflite.query(table);
  }
}