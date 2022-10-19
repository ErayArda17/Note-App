import 'dart:io';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqflite/sqflite.dart';

import '../models/classnotlar.dart';

class Databasehelper {
  static Databasehelper? _databasehelper;
  static Database? _database;

  factory Databasehelper() {
    if (_databasehelper == null) {
      _databasehelper = Databasehelper?._internal();
      return _databasehelper!;
    } else {
      return _databasehelper!;
    }
  }
  Databasehelper._internal();

  Future<Database> _getdatabase() async {
    if (_database == null) {
      _database = await _initilazeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initilazeDatabase() async {
    var lock = Lock();
    Database? _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "appDB.db");
          print("Db path:$path");
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data = await rootBundle.load(join("assets", "notlar.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db!;
  }

  Future<List<Map<String, dynamic>>> kategorigetir() async {
    var db = await _getdatabase();
    var sonuc = await db.query("kategori");
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> notlarigetir() async {
    var db = await _getdatabase();
    var notsonuc =
        await db.rawQuery('select * from "not" order by notBaslik;');
    return notsonuc;
  }

  Future<List<Not>> notlistesigetir() async {
    var notlarmaplistesi = await notlarigetir();
    var notlistesi = <Not>[];
    for (Map map in notlarmaplistesi) {
      notlistesi.add(Not.fromMap(map));
    }
    return notlistesi;
  }

  Future<int> notguncelle(Not not) async {
    var db = await _getdatabase();
    var notlar = await db
        .update("not", not.toMap(), where: 'notID=?', whereArgs: [not.notID]);
    return notlar;
  }

  Future<int> notSil(int notID) async {
    var db = await _getdatabase();
    var notlar = await db.delete("not", where: 'notID=?', whereArgs: [notID]);
    return notlar;
  }

  Future<int> notekle(Not not) async {
    var db = await _getdatabase();
    var notlar = await db.insert("not", not.toMap());
    return notlar;
  }
}
