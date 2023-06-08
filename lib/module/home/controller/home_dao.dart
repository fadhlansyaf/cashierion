import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app_skripsi/utils/constant.dart';
import 'package:pos_app_skripsi/utils/preferences.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class HomeDao {
  Future<RxList<PaymentTypeModel>> getAllPaymentType() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentType);
    List<PaymentTypeModel> paymentTypeList =
        List.from(result.map((e) => PaymentTypeModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<RxList<PaymentDetailModel>> getPaymentDetail(
      PaymentTypeModel paymentType) async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentDetail,
        where: 'payment_type_id = ?', whereArgs: [paymentType.id]);
    List<PaymentDetailModel> paymentTypeList =
        List.from(result.map((e) => PaymentDetailModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<void> insertPaymentType(PaymentTypeModel paymentType) async {
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.paymentType, paymentType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertPaymentDetail(PaymentDetailModel paymentDetail) async {
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.paymentDetail, paymentDetail.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTransaction(
      TransactionModel transaction, List<ProductModel> productList) async {
    Database db = await DatabaseProvider().database;
    final transactionId = await db.insert(
        DatabaseProvider.transactionTable, transaction.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    var batch = db.batch();
    for (var e in productList) {
      var transactionDetail = TransactionDetailModel(
          transactionId: transactionId,
          productId: e.id,
          quantity: e.quantity.value,
          //TODO: ganti description dari textController
          description: e.description);
      batch.insert(
          DatabaseProvider.transactionDetailTable, transactionDetail.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      batch.update(DatabaseProvider.productTable,
          e.copyWith(stock: e.stock - e.quantity.value).toJson(),
          where: 'product_id = ?', whereArgs: [e.id]);
    }
    batch.commit();
  }

  //TODO: Ganti price berdasarkan order/restock
  Future<List<PredictionModel>> manipulateData() async {
    Database db = await DatabaseProvider().database;

    var query = '''
    SELECT ${DatabaseProvider.transactionDetailTable}.product_id AS item, ${DatabaseProvider.productTable}.selling_price * ${DatabaseProvider.transactionDetailTable}.quantity AS sales, ${DatabaseProvider.transactionTable}.dates FROM TransactionDetails
    JOIN ${DatabaseProvider.transactionTable} on ${DatabaseProvider.transactionTable}.transaction_id = ${DatabaseProvider.transactionDetailTable}.transaction_id
    JOIN ${DatabaseProvider.productTable} on ${DatabaseProvider.productTable}.product_id = ${DatabaseProvider.transactionDetailTable}.product_id
    ''';

    final dateRange = await db.rawQuery(
        'SELECT MIN(dates) AS minDate, MAX(dates) AS maxDate FROM ${DatabaseProvider.transactionTable}');
    final minDate = DateTime.parse(dateRange.first['minDate'] as String);
    final maxDate = DateTime.parse(dateRange.first['maxDate'] as String);

    final startDateRaw = maxDate
        .subtract(Duration(days: 2 * 365)); // Starting date two years earlier
    final endDate = DateTime(maxDate.year, maxDate.month, maxDate.day, 23, 59); // Ending date is the latest date in the database
    var startDate = DateTime(startDateRaw.year, startDateRaw.month, startDateRaw.day, 23, 59);

    final records = await db.rawQuery(query);

    final List<PredictionModel> manipulatedData = [];

    final durationDays = (maxDate.add(const Duration(days: 1))).difference(minDate).inDays.toDouble();
    final recordCount = records.length;
    final loopCount = (2 * 365 / durationDays).ceil();

    for (var i = 0; i < loopCount; i++) {
      final currentDate =
          startDate.add(Duration(days: (i * durationDays).toInt()));
      final endDateLoop = currentDate.add(Duration(days: durationDays.toInt()));
      final dateDiff = endDateLoop.difference(currentDate).inDays;
      for (var e in records) {
        var model = PredictionModel.fromJson(e);
        final manipulatedDate = DateTime.parse(model.dates).add(Duration(days: dateDiff));
        if (model.dateTime.isAfter(currentDate) &&
            model.dateTime.isBefore(endDate)) {
          manipulatedData.add(PredictionModel(item: model.item, sales: model.sales, dates: DateFormat(DateTimeFormat.standard).format(manipulatedDate)));
        }
      }
    }

    return manipulatedData;
  }
}
