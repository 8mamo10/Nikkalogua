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

  ///// Nikka and Log
  Future<List<Map<String, dynamic>>> getAllNikkasAndLogs() async {
    List<Map<String, dynamic>> ret = [];
    List<Nikka> nikkas = await this.getAllNikkas();
    for (int i = 0; i < nikkas.length; i++) {
      Nikka nikka = nikkas[i];
      List<Log> logs = await this.getLogsByNikkaId(nikka.id);
      Map<String, dynamic> data = {
        'nikka': nikka,
        'logs': logs,
      };
      ret.add(data);
    }
    return ret;
  }

  ///// Nikka
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

  deleteAllNikkas() async {
    final db = await database;
    db.rawDelete("DELETE FROM nikka");
  }

  ///// Log
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

  Future<List<Log>> getLogsByNikkaId(int nikkaId) async {
    final db = await database;
    var res = await db.query("log",
        where: "nikka_id = ?", whereArgs: [nikkaId], orderBy: "date DESC");
    List<Log> list =
        res.isNotEmpty ? res.map((l) => Log.fromMap(l)).toList() : [];
    return list;
  }

  Future<List<Log>> getAllLogs() async {
    final db = await database;
    var res = await db.query("log");
    List<Log> list =
        res.isNotEmpty ? res.map((l) => Log.fromMap(l)).toList() : [];
    return list;
  }

  deleteLog(int id) async {
    final db = await database;
    db.delete("log", where: "id = ?", whereArgs: [id]);
  }

  deleteLogsByNikkaId(int nikkaId) async {
    final db = await database;
    db.delete("log", where: "nikka_id = ?", whereArgs: [nikkaId]);
  }

  deleteAllLogs() async {
    final db = await database;
    db.rawDelete("DELETE FROM log");
  }
}
