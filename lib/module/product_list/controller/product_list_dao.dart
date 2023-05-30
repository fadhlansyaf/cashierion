import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../service/database_provider.dart';

class ProductListDao{
  Future<List<Products>> getAllItem() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.productTable);
    List<Products> products = List.from(result.map((e) => Products.fromJson(e)));
    return products;
  }
}