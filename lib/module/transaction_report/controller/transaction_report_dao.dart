import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:pos_app_skripsi/model/database/category.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/database_model.dart';
import '../../../model/database/product.dart';
import '../../../service/database_provider.dart';
import '../../../utils/constant.dart';

class TransactionReportDao{
  Future<RxList<ReportProductModel>> getTotalQuantity(DateTime dateStart, DateTime dateEnd, int type) async{
    try {
      Database db = await DatabaseProvider().database;
      var query = '''
    SELECT ${DatabaseProvider.productTable}.product_id, ${DatabaseProvider.productTable}.name, SUM(${DatabaseProvider.transactionDetailTable}.quantity) AS totalQuantity, ${DatabaseProvider.productTable}.price, ${DatabaseProvider.productTable}.selling_price
      FROM ${DatabaseProvider.transactionTable}
      JOIN ${DatabaseProvider.transactionDetailTable} ON ${DatabaseProvider.transactionTable}.transaction_id = ${DatabaseProvider.transactionDetailTable}.transaction_id
      JOIN ${DatabaseProvider.productTable} ON ${DatabaseProvider.productTable}.product_id = ${DatabaseProvider.transactionDetailTable}.product_id
      WHERE ${DatabaseProvider.transactionTable}.dates >= ? AND ${DatabaseProvider.transactionTable}.dates <= ? AND ${DatabaseProvider.transactionTable}.invoice LIKE ?
      GROUP BY ${DatabaseProvider.productTable}.product_id, ${DatabaseProvider.productTable}.name
      ''';
      var result = await db.rawQuery(query, [DateFormat(DateTimeFormat.standard).format(dateStart), DateFormat(DateTimeFormat.standard).format(dateEnd), type == 0 ? 'CO%' : 'CS%']);
      var report = result.map((e) => ReportProductModel.fromJson(e)).toList();
      return report.obs;
    } catch (e) {
      print(e);
      return <ReportProductModel>[].obs;
    }
  }
}