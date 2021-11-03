//SQLのモデル定義

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PasswordModel {
  final int id;
  final String type;
  final String pass;
  final String mail;

  PasswordModel(
      {required this.id,
      required this.type,
      required this.pass,
      required this.mail});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'pass': pass,
      'mail': mail,
    };
  }

  @override
  String toString() {
    return 'PasswordModel{id:$id,type:$type,pass:$pass,mail:$mail}';
  }

  static Future<Database> get database async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pass(id INTEGER PRIMARY KEY, type TEXT, pass TEXT,mail TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<List<PasswordModel>> getData() async {
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

  static Future<void> insertData(PasswordModel passModel) async {
    final Database db = await database;
    await db.insert(
      'pass',
      passModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete(
      'pass',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> updateData(PasswordModel passModel) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      'pass',
      passModel.toMap(),
      where: "id = ?",
      whereArgs: [passModel.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }
}
