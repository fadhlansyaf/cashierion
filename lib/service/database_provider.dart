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

  static _createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cashierion.db');

    Database database = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade, onConfigure: _onConfigure);
    return database;
  }


  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  static Future<void> _onCreate(Database db, int version) async {
    // Batch batch = db.batch();
    for (var script in _initScript) {
      db.execute(script);
    }
    // await batch.commit(noResult: true);

    // Batch batch2 = db.batch();
    // for (var script in _secondInitScript) {
    //   db.execute(script);
    // }
    // await batch2.commit(noResult: true);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static const productCategoryTable = 'ProductCategory';
  static const productTable = 'Products';
  static const transactionTable = 'Transactions';

  static final List<String> _initScript = [
    'CREATE TABLE $productCategoryTable('
        'product_category_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        'name TEXT NOT NULL,'
        'description TEXT'
        ')',
    'CREATE TABLE $productTable ('
        'product_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        'name TEXT NOT NULL,'
        'image TEXT,'
        'price REAL,'
        'selling_price REAL NOT NULL,'
        'stock INTEGER,'
        'description TEXT,'
        'FOREIGN KEY(product_id) REFERENCES $productCategoryTable(product_category_id)'
        ')',
  ];
}