import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:nikkalogua/NikkaModel.dart';
import 'package:nikkalogua/LogModel.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Nikkalogua.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE nikka ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "color INTEGER"
          ")");
      await db.execute("CREATE TABLE log ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nikka_id INTEGER,"
          "date TEXT"
          ")");
    });
  }

  newNikka(Nikka newNikka) async {
    final db = await database;
    var res = await db.insert("nikka", newNikka.toMap());
    return res;
  }

  Future<Nikka> getNikka(int id) async {
    final db = await database;
    var res = await db.query("nikka", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Nikka.fromMap(res.first) : null;
  }

  Future<List<Nikka>> getAllNikkas() async {
    final db = await database;
    var res = await db.query("nikka");
    List<Nikka> list =
        res.isNotEmpty ? res.map((n) => Nikka.fromMap(n)).toList() : [];
    return list;
  }

  updateNikka(Nikka newNikka) async {
    final db = await database;
    var res = db.update("nikka", newNikka.toMap(),
        where: "id = ?", whereArgs: [newNikka.id]);
    return res;
  }

  deleteNikka(int id) async {
    final db = await database;
    db.delete("nikka", where: "id = ?", whereArgs: [id]);
  }

  deleteAllNikka() async {
    final db = await database;
    db.rawDelete("DELETE FROM nikka");
  }

  newLog(Log newLog) async {
    final db = await database;
    var res = await db.insert("log", newLog.toMap());
    return res;
  }

  Future<Log> getLog(int id) async {
    final db = await database;
    var res = await db.query("log", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Log.fromMap(res.first) : null;
  }
}
