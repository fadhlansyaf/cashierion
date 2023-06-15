import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class ProductDetailDao{
  Future<bool?> deleteItem(ProductModel product) async {
    try {
      Database db = await DatabaseProvider().database;
      var rawQuery = '''
      SELECT COUNT(product_id) AS detailCount FROM ${DatabaseProvider.transactionDetailTable} WHERE product_id = ?
      ''';
      var countTransactionDetailWithProductId = (await db.rawQuery(rawQuery, [product.id])).first['detailCount'] as int;
      //Jika tidak ada transaction detail dengan product id yg dipilih
      if(countTransactionDetailWithProductId <= 0) {
        await db.delete(DatabaseProvider.productTable,
            where: 'product_id = ?', whereArgs: [product.id]);
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}