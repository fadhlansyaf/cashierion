import 'package:get/get.dart';
import 'package:cashierion/model/database/category.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/product.dart';
import '../../../service/database_provider.dart';

class CategoryListDao{
  Future<RxList<CategoryModel>> getCategoryList() async {
    try {
      Database db = await DatabaseProvider().database;
      var query = await db.query(DatabaseProvider.productCategoryTable);
      var category = query.map((e) => CategoryModel.fromJson(e)).toList();
      return category.obs;
    } catch (e) {
      print(e);
      return <CategoryModel>[].obs;
    }
  }

  Future<int> checkCategoryCount(CategoryModel category) async{
    try {
      Database db = await DatabaseProvider().database;
      var query = await db.query(DatabaseProvider.productTable, where: 'product_category_id = ?', whereArgs: [category.id]);
      return query.map((e) => ProductModel.fromJson(e)).toList().length;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}