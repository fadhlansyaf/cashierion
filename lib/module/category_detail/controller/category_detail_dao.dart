import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class CategoryDetailDao{
  Future<void> deleteCategory(CategoryModel category) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.delete(DatabaseProvider.productCategoryTable, where: 'product_category_id = ?', whereArgs: [category.id]);
    }  catch (e) {
      print(e);
    }
  }
}