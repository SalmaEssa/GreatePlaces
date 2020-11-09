import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> dataBase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: (db, version) => db.execute(
            "CREATE TABLE Greateplaces(id Text Primary Key, title Text, image Text, long real, lat real, adress Text)"),
        version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await dataBase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await dataBase();
    return db.query(table);
  }
}
