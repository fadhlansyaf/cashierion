import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app_skripsi/utils/constant.dart';
import 'package:pos_app_skripsi/utils/preferences.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class HomeDao {
  Future<double> getFinanceSales() async {
    Database db = await DatabaseProvider().database;
    var query = '''
    SELECT SUM(${DatabaseProvider.productTable}.selling_price*${DatabaseProvider.transactionDetailTable}.quantity) AS Sales
    FROM ${DatabaseProvider.transactionTable}
    JOIN ${DatabaseProvider.transactionDetailTable} ON ${DatabaseProvider.transactionDetailTable}.transaction_id = ${DatabaseProvider.transactionTable}.transaction_id
    JOIN ${DatabaseProvider.productTable} ON ${DatabaseProvider.productTable}.product_id = ${DatabaseProvider.transactionDetailTable}.product_id
    WHERE ${DatabaseProvider.transactionTable}.invoice LIKE 'CO%' AND ${DatabaseProvider.transactionTable}.dates BETWEEN ? AND ?
    ''';
    var now = DateTime.now();

    DateTime startDate = DateTime(now.year, now.month, 1);
    DateTime endDate = DateTime(now.year, now.month + 1, 0);

    String formattedStartDate =
        DateFormat(DateTimeFormat.standard).format(startDate);
    String formattedEndDate =
        DateFormat(DateTimeFormat.standard).format(endDate);
    var result =
        await db.rawQuery(query, [formattedStartDate, formattedEndDate]);
    return result.first['Sales'] as double;
  }

  Future<double> getFinanceExpenditure() async {
    Database db = await DatabaseProvider().database;
    var query = '''
    SELECT SUM(${DatabaseProvider.productTable}.price*${DatabaseProvider.transactionDetailTable}.quantity) AS Expenditure
    FROM ${DatabaseProvider.transactionTable}
    JOIN ${DatabaseProvider.transactionDetailTable} ON ${DatabaseProvider.transactionDetailTable}.transaction_id = ${DatabaseProvider.transactionTable}.transaction_id
    JOIN ${DatabaseProvider.productTable} ON ${DatabaseProvider.productTable}.product_id = ${DatabaseProvider.transactionDetailTable}.product_id
    WHERE ${DatabaseProvider.transactionTable}.invoice LIKE 'CS%' AND ${DatabaseProvider.transactionTable}.dates BETWEEN ? AND ?
    ''';
    var now = DateTime.now();

    DateTime startDate = DateTime(now.year, now.month, 1);
    DateTime endDate = DateTime(now.year, now.month + 1, 0);

    String formattedStartDate =
        DateFormat(DateTimeFormat.standard).format(startDate);
    String formattedEndDate =
        DateFormat(DateTimeFormat.standard).format(endDate);
    var result =
        await db.rawQuery(query, [formattedStartDate, formattedEndDate]);
    return result.first['Expenditure'] as double;
  }

  ///Return sudah pasti 2 value, index 0 TotalTransaction dan index 1 TotalProductsSold
  Future<List<num>> getTodayTransaction() async {
    Database db = await DatabaseProvider().database;
    var query = '''
    SELECT COUNT(${DatabaseProvider.transactionTable}.transaction_id) AS totalTransaction, SUM(${DatabaseProvider.transactionDetailTable}.quantity) AS totalProductsSold
    FROM ${DatabaseProvider.transactionTable}
    JOIN ${DatabaseProvider.transactionDetailTable} ON ${DatabaseProvider.transactionDetailTable}.transaction_id = ${DatabaseProvider.transactionTable}.transaction_id
    WHERE ${DatabaseProvider.transactionTable}.dates BETWEEN ? AND ? AND ${DatabaseProvider.transactionTable}.invoice LIKE 'CO%'
    ''';
    var now = DateTime.now();
    var startDay = DateFormat(DateTimeFormat.standard)
        .format(DateTime(now.year, now.month, now.day - 1, 23, 59));
    var endDay = DateFormat(DateTimeFormat.standard)
        .format(DateTime(now.year, now.month, now.day + 1));
    var result = (await db.rawQuery(query, [startDay, endDay])).first;
    return [result['totalTransaction'] as num, result['totalProductsSold'] as num];
  }

  Future<RxList<PaymentTypeModel>> getAllPaymentType() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentType);
    List<PaymentTypeModel> paymentTypeList =
        List.from(result.map((e) => PaymentTypeModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<RxList<PaymentDetailModel>> getAllPaymentDetail() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentDetail);
    List<PaymentDetailModel> paymentTypeList =
        List.from(result.map((e) => PaymentDetailModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<void> deletePaymentDetail(PaymentDetailModel paymentDetail) async {
    Database db = await DatabaseProvider().database;
    await db.delete(DatabaseProvider.paymentDetail,
        where: 'payment_detail_id = ?', whereArgs: [paymentDetail.id]);
  }

  Future<PaymentTypeModel> getPaymentTypeUsingPaymentDetailId(
      PaymentDetailModel paymentDetail) async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentType,
        where: 'payment_type_id = ?', whereArgs: [paymentDetail.paymentTypeId]);
    PaymentTypeModel paymentTypeList =
        result.map((e) => PaymentTypeModel.fromJson(e)).first;
    return paymentTypeList;
  }

  Future<void> deletePaymentType(PaymentTypeModel paymentType) async {
    Database db = await DatabaseProvider().database;
    await db.delete(DatabaseProvider.paymentType,
        where: 'payment_type_id = ?', whereArgs: [paymentType.id]);
  }

  Future<RxList<PaymentDetailModel>> getPaymentDetailUsingPaymentType(
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

  Future<void> editPaymentDetail(PaymentDetailModel paymentDetail) async {
    Database db = await DatabaseProvider().database;
    await db.update(DatabaseProvider.paymentDetail, paymentDetail.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'payment_detail_id = ?',
        whereArgs: [paymentDetail.id]);
  }

  Future<void> editPaymentType(PaymentTypeModel paymentType) async {
    Database db = await DatabaseProvider().database;
    await db.update(DatabaseProvider.paymentType, paymentType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'payment_type_id = ?',
        whereArgs: [paymentType.id]);
  }

  Future<void> insertTransaction(TransactionModel transaction,
      List<ProductModel> productList, bool isOrder) async {
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
      batch.update(
          DatabaseProvider.productTable,
          e
              .copyWith(
                  stock: isOrder
                      ? e.stock - e.quantity.value
                      : e.stock + e.quantity.value)
              .toJson(),
          where: 'product_id = ?',
          whereArgs: [e.id]);
    }
    batch.commit();
  }

  Future<Map<String, dynamic>> manipulateData() async {
    Database db = await DatabaseProvider().database;

    var query = '''
    SELECT ${DatabaseProvider.transactionDetailTable}.product_id AS item, ${DatabaseProvider.productTable}.selling_price * ${DatabaseProvider.transactionDetailTable}.quantity AS sales, ${DatabaseProvider.transactionTable}.dates FROM TransactionDetails
    JOIN ${DatabaseProvider.transactionTable} on ${DatabaseProvider.transactionTable}.transaction_id = ${DatabaseProvider.transactionDetailTable}.transaction_id
    JOIN ${DatabaseProvider.productTable} on ${DatabaseProvider.productTable}.product_id = ${DatabaseProvider.transactionDetailTable}.product_id
    ''';

    final dateRange = await db.rawQuery(
        'SELECT MIN(dates) AS minDate, MAX(dates) AS maxDate FROM ${DatabaseProvider.transactionTable}');

    if (dateRange.first['minDate'] != null) {
      final minDateRaw = DateTime.parse(dateRange.first['minDate'] as String);
      final minDate =
          DateTime(minDateRaw.year, minDateRaw.month, minDateRaw.day, 0, 0);
      final maxDateRaw = DateTime.parse(dateRange.first['maxDate'] as String);
      final maxDate =
          DateTime(maxDateRaw.year, maxDateRaw.month, maxDateRaw.day, 23, 59);

      if (minDate.difference(maxDate).abs() >= Duration(days: 30)) {
        final startDateRaw = maxDate.subtract(
            Duration(days: 2 * 365)); // Starting date two years earlier
        final endDate = DateTime(maxDate.year, maxDate.month, maxDate.day, 23,
            59); // Ending date is the latest date in the database
        var startDate = DateTime(
            startDateRaw.year, startDateRaw.month, startDateRaw.day, 23, 59);

        final records = await db.rawQuery(query);

        final List<PredictionModel> manipulatedData = [];

        final durationDays = (maxDate.add(const Duration(days: 1)))
            .difference(minDate)
            .inDays
            .toDouble();
        final recordCount = records.length;
        final loopCount = (2 * 365 / durationDays).ceil();

        for (var i = 0; i < loopCount; i++) {
          final currentDate =
              startDate.add(Duration(days: (i * durationDays).toInt()));
          final endDateLoop =
              currentDate.add(Duration(days: durationDays.toInt()));
          final dateDiff = currentDate.difference(startDate).inDays;
          for (var e in records) {
            var model = PredictionModel.fromJson(e);
            final firstManipulatedDate =
                model.dateTime.add(Duration(days: dateDiff));
            final manipulatedDate = DateTime(currentDate.year,
                firstManipulatedDate.month, firstManipulatedDate.day);
            if (model.dateTime.isAfter(currentDate) &&
                model.dateTime.isBefore(endDate)) {
              manipulatedData.add(PredictionModel(
                  item: model.item,
                  sales: model.sales,
                  dates: DateFormat(DateTimeFormat.standard)
                      .format(manipulatedDate)));
            }
          }
        }
        Map<String, int> item = {};
        Map<String, double> sales = {};
        Map<String, String> dates = {};
        for (int i = 0; i < manipulatedData.length; i++) {
          var e = manipulatedData[i];
          item.addAll({i.toString(): e.item});
          sales.addAll({i.toString(): e.sales});
          dates.addAll({i.toString(): e.dates.split(' ').first});
        }
        return {
          "data": jsonEncode({"item": item, "sales": sales, "dates": dates})
        };
      } else {
        return {};
      }
    } else {
      return {};
    }
  }
}
