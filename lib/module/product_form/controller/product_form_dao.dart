import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductFormDao {
  Future<void> insertItem(ProductModel product) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.insert(DatabaseProvider.productTable, product.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<void> editItem(ProductModel product) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.update(DatabaseProvider.productTable, product.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'product_id = ?',
          whereArgs: [product.id]);
    } catch (e) {
      print(e);
    }
  }
}
