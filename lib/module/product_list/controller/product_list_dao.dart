import 'package:get/get.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../service/database_provider.dart';

class ProductListDao{
  Future<RxList<ProductModel>> getAllProducts() async {
    try {
      Database db = await DatabaseProvider().database;
      var result = await db.query(DatabaseProvider.productTable);
      List<ProductModel> products = List.from(result.map((e) => ProductModel.fromJson(e)));
      return products.obs;
    } catch (e) {
      print(e);
      return <ProductModel>[].obs;
    }
  }
}