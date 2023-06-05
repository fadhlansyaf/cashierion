import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class CategoryDetailDao{
  Future<void> deleteItem(CategoryModel product) async {
    Database db = await DatabaseProvider().database;
    await db.delete(DatabaseProvider.productTable, where: 'product_id = ?', whereArgs: [product.id]);
  }
}