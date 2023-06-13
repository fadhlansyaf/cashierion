import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/utils/constant.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/product.dart';
import '../../../service/database_provider.dart';

class TransactionHistoryListDao{
  Future<RxList<TransactionModel>> getTransactionList(DateTime dateStart, DateTime dateEnd, int type) async {
    try {
      Database db = await DatabaseProvider().database;
      var query = await db.query(DatabaseProvider.transactionTable, where: 'dates >= ? AND dates <= ?', whereArgs: [DateFormat(DateTimeFormat.standard).format(dateStart), DateFormat(DateTimeFormat.standard).format(dateEnd)]);
      var transactions = query.map((e) => TransactionModel.fromJson(e)).toList().where((e) => e.invoice.startsWith(type == 0 ? 'CO' : 'CS')).toList();
      return transactions.obs;
    } catch (e) {
      print(e);
      return <TransactionModel>[].obs;
    }
  }

  Future<int> checkTransactionDetailCount(TransactionModel transaction) async{
    try {
      Database db = await DatabaseProvider().database;
      var query = await db.query(DatabaseProvider.transactionDetailTable, where: 'transaction_id = ?', whereArgs: [transaction.id]);
      return query.map((e) => TransactionDetailModel.fromJson(e)).toList().length;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}