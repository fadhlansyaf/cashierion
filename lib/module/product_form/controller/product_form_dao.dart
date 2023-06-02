import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductFormDao{
  Future<void> insertItem(ProductModel productForm) async {
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.productTable, productForm.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}