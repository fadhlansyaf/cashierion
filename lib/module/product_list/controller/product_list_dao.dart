import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../service/database_provider.dart';

class ProductListDao{
  Future<List<ProductModel>> getAllItem() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.productTable);
    List<ProductModel> products = List.from(result.map((e) => ProductModel.fromJson(e)));
    return products;
  }
}