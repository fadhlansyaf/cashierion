import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class CategoryDetailDao{
  Future<bool?> deleteCategory(CategoryModel category) async {
    try {
      Database db = await DatabaseProvider().database;
      var rawQuery ='''
      SELECT COUNT(product_id) AS productCount FROM ${DatabaseProvider.productTable} WHERE product_category_id = ?
      ''';
      var countProductWithCategoryId = (await db.rawQuery(rawQuery, [category.id])).first['productCount'] as int;
      //Jika tidak ada produk dengan categori yang dipilih
      if(countProductWithCategoryId <= 0) {
        await db.delete(DatabaseProvider.productCategoryTable,
            where: 'product_category_id = ?', whereArgs: [category.id]);
        return true;
      }else{
        return false;
      }
    }  catch (e) {
      print(e);
    }
    return null;
  }
}