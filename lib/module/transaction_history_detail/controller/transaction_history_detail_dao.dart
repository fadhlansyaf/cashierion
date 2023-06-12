import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class TransactionHistoryDetailDao{
  Future<RxList<TransactionDetailModel>> getTransactionDetails(TransactionModel transaction) async {
    Database db = await DatabaseProvider().database;
    var query = await db.query(DatabaseProvider.transactionDetailTable, where: 'transaction_id = ?', whereArgs: [transaction.id]);
    var transactionDetail = query.map((e) => TransactionDetailModel.fromJson(e)).toList();
    return transactionDetail.obs;
  }

  Future<Rx<TransactionModel>> refreshTransaction(TransactionModel transaction) async {
    Database db = await DatabaseProvider().database;
    var query = await db.query(DatabaseProvider.transactionTable, where: 'transaction_id = ?', whereArgs: [transaction.id]);
    var transactionDetail = query.map((e) => TransactionModel.fromJson(e)).first;
    return transactionDetail.obs;
  }

  Future<ProductModel> getProduct(TransactionDetailModel transactionDetail) async {
    Database db = await DatabaseProvider().database;
    var query = await db.query(DatabaseProvider.productTable, where: 'product_id = ?', whereArgs: [transactionDetail.productId]);
    var product = query.map((e) => ProductModel.fromJson(e)).first;
    return product;
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    Database db = await DatabaseProvider().database;
    await db.delete(DatabaseProvider.transactionDetailTable, where: 'transaction_id = ?', whereArgs: [transaction.id]);
    var query = await db.delete(DatabaseProvider.transactionTable, where: 'transaction_id = ?', whereArgs: [transaction.id]);
  }
  // Future<void> deleteCategory(CategoryModel category) async {
  //   Database db = await DatabaseProvider().database;
  //   await db.delete(DatabaseProvider.productCategoryTable, where: 'product_category_id = ?', whereArgs: [category.id]);
  // }
}