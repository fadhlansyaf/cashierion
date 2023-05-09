import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }else {
      _database = await _createDatabase();
      return _database!;
    }
  }

  _createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cashierion.db');

    Database database = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }


  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    for (var script in _initScript) {
      batch.execute(script);
    }
    await batch.commit(noResult: true);
  }

  static const productTable = 'Products';

  final List<String> _initScript = [
    'CREATE TABLE $productTable ('
        'id INTEGER PRIMARY KEY,'
        'productName TEXT,'
        'price INTEGER,'
        'desc STRING'
        ')',
  ];
}