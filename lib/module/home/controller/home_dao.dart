import 'package:get/get.dart';

import '../../../model/database/database_model.dart';
import '../../../service/database_provider.dart';

class HomeDao{
  Future<RxList<PaymentTypeModel>> getAllPaymentType() async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentType);
    List<PaymentTypeModel> paymentTypeList = List.from(result.map((e) => PaymentTypeModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<RxList<PaymentDetailModel>> getPaymentDetail(PaymentTypeModel paymentType) async {
    Database db = await DatabaseProvider().database;
    var result = await db.query(DatabaseProvider.paymentDetail, where: 'payment_type_id = ?', whereArgs: [paymentType.id]);
    List<PaymentDetailModel> paymentTypeList = List.from(result.map((e) => PaymentDetailModel.fromJson(e)));
    return paymentTypeList.obs;
  }

  Future<void> insertPaymentType(PaymentTypeModel paymentType)async{
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.paymentType, paymentType.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertPaymentDetail(PaymentDetailModel paymentDetail)async{
    Database db = await DatabaseProvider().database;
    await db.insert(DatabaseProvider.paymentDetail, paymentDetail.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

  }
}