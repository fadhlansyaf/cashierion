import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductDetailDao{
  Future<void> deleteItem(ProductModel product) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.delete(DatabaseProvider.productTable, where: 'product_id = ?', whereArgs: [product.id]);
    } catch (e) {
      print(e);
    }
  }
}