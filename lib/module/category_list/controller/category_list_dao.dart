import 'package:get/get.dart';
import 'package:pos_app_skripsi/model/database/category.dart';
import 'package:sqflite/sqflite.dart';

import '../../../service/database_provider.dart';

class CategoryListDao{
  Future<RxList<CategoryModel>> getCategoryList() async {
    Database db = await DatabaseProvider().database;
    var query = await db.query(DatabaseProvider.productCategoryTable);
    var category = query.map((e) => CategoryModel.fromJson(e)).toList();
    return category.obs;
  }
}