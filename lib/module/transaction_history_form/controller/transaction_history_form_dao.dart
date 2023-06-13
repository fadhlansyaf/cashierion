import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/category.dart';
import '../../../service/database_provider.dart';

class TransactionHistoryFormDao {
  Future<void> editTransactionDetails(
      List<TransactionDetailModel> transactionDetail,
      TransactionModel transaction) async {
    try {
      Database db = await DatabaseProvider().database;
      var batch = db.batch();
      db.update(DatabaseProvider.transactionTable, transaction.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'transaction_id = ?',
          whereArgs: [transaction.id]);
      for (var e in transactionDetail) {
        await db.update(DatabaseProvider.transactionDetailTable, e.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
            where: 'product_id = ? AND transaction_id = ?',
            whereArgs: [e.productId, e.transactionId]);
      }
      await batch.commit();
    } catch (e) {
      print(e);
    }
  }
}
