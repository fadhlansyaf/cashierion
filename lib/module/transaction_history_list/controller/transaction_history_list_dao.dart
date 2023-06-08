import 'package:get/get.dart';
// import 'package:pos_app_skripsi/model/database/category.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/product.dart';
import '../../../service/database_provider.dart';

class TransactionHistoryListDao{
  // Future<RxList<CategoryModel>> getCategoryList() async {
  //   Database db = await DatabaseProvider().database;
  //   var query = await db.query(DatabaseProvider.productCategoryTable);
  //   var category = query.map((e) => CategoryModel.fromJson(e)).toList();
  //   return category.obs;
  // }

  // Future<int> checkCategoryCount(CategoryModel category) async{
  //   Database db = await DatabaseProvider().database;
  //   var query = await db.query(DatabaseProvider.productTable, where: 'product_category_id = ?', whereArgs: [category.id]);
  //   return query.map((e) => ProductModel.fromJson(e)).toList().length;
  // }
}