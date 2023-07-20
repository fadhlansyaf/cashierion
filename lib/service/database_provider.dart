import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

export 'package:sqflite/sqflite.dart';

///Class untuk menggunakan database SQLite pada app Cashierion
class DatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _createDatabase();
      return _database!;
    }
  }

  static _createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cashierion.db');

    Database database = await openDatabase(path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure);
    return database;
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {}

  static Future<void> _onCreate(Database db, int version) async {
    //Menjalankan semua script pada _initScript
    for (var script in _initScript) {
      db.execute(script);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static const productCategoryTable = 'ProductCategory';
  static const productTable = 'Products';
  static const paymentTypeTable = 'PaymentType';
  static const paymentDetail = 'PaymentDetail';
  static const transactionTable = 'Transactions';
  static const transactionDetailTable = 'TransactionDetails';

  ///List script yang perlu dirun untuk membuat database
  ///
  /// [productCategoryTable] dan [paymentTypeTable] mempunyai initial value
  static final List<String> _initScript = [
    '''
  CREATE TABLE $productCategoryTable(
    product_category_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    description TEXT
  )
  ''',
    '''
  CREATE TABLE $productTable (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    product_category_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    image TEXT,
    price REAL NOT NULL,
    selling_price REAL NOT NULL,
    stock INTEGER,
    description TEXT,
    FOREIGN KEY(product_category_id) REFERENCES $productCategoryTable(product_category_id)
  )
  ''',
    '''
  INSERT INTO $productCategoryTable(product_category_id, name) VALUES(0, 'No Category')
  ''',
    '''
    CREATE TABLE $paymentTypeTable (
      payment_type_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      payment_name TEXT NOT NULL
    )
    ''',
    '''
      INSERT INTO $paymentTypeTable (payment_name) VALUES('Cash')
    ''',
    '''
    CREATE TABLE $paymentDetail (
      payment_detail_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      payment_type_id INTEGER NOT NULL,
      description TEXT,
      FOREIGN KEY(payment_type_id) REFERENCES $paymentTypeTable(payment_type_id)
    )
    ''',
    '''
    CREATE TABLE $transactionTable (
      transaction_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      payment_type_id INTEGER NOT NULL,
      payment_detail_id INTEGER,
      invoice TEXT NOT NULL,
      dates TEXT NOT NULL,
      sales REAL NOT NULL,
      FOREIGN KEY(payment_type_id) REFERENCES $paymentTypeTable(payment_type_id),
      FOREIGN KEY(payment_detail_id) REFERENCES $paymentDetail(payment_detail_id)
    )
    ''',
    '''
    CREATE TABLE $transactionDetailTable (
      transaction_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      quantity INTEGER,
      description TEXT,
      FOREIGN KEY(transaction_id) REFERENCES $transactionTable(transaction_id),
      FOREIGN KEY(product_id) REFERENCES $productTable(product_id)
    )
    ''',
  ];
}
