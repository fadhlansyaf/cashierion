import 'package:sqflite/sqflite.dart';

import '../../../model/database/category.dart';
import '../../../service/database_provider.dart';

class CategoryFormDao {
  Future<void> insertCategory(CategoryModel category) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.insert(DatabaseProvider.productCategoryTable, category.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }  catch (e) {
      print(e);
    }
  }

  Future<void> editCategory(CategoryModel category) async {
    try {
      Database db = await DatabaseProvider().database;
      await db.update(DatabaseProvider.productCategoryTable, category.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'product_category_id = ?',
          whereArgs: [category.id]);
    } catch (e) {
      print(e);
    }
  }
}
