import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:password_memo/model/model.dart';

/*
void makeTable() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE pass(id INTEGER PRIMARY KEY, type TEXT, pass TEXT,mail TEXT)",
      );
    },
    version: 1,
  );

  Future<void> insertData(PasswordModel passModel) async {
    final Database db = await database;
    await db.insert(
      'pass',
      passModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PasswordModel>> getData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pass');
    return List.generate(maps.length, (i) {
      return PasswordModel(
          id: maps[i]['id'],
          type: maps[i]['type'],
          pass: maps[i]['pass'],
          mail: maps[i]['mail']);
    });
  }

  Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      'pass',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
*/