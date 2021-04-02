import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:nikkalogua/NikkaModel.dart';

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
    var res = await db.insert("Nikka", newNikka.toMap());
    return res;
  }

  getNikka(int id) async {
    final db = await database;
    var res = await db.query("Nikka", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Nikka.fromMap(res.first) : null;
  }

  Future<List<Nikka>> getAllNikkas() async {
    final db = await database;
    var res = await db.query('Nikka');
    List<Nikka> list = res.isNotEmpty ? res.map((n)=>Nikka.fromMap(n)).toList() : [];
    return list;
  }

}
