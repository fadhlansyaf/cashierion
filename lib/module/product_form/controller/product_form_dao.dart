import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductFormDao{
  Future<void> insertItem(ProductModel product) async {
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.productTable, product.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> editItem(ProductModel product) async {
    Database db = await DatabaseProvider().database;
    await db.update(DatabaseProvider.productTable, product.toJson(), conflictAlgorithm: ConflictAlgorithm.replace, where: 'product_id = ?', whereArgs: [product.id]);
  }
}