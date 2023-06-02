import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductDetailDao{
  Future<void> insertItem(ProductModel productDetail) async {
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.productTable, productDetail.toJson());
  }
}