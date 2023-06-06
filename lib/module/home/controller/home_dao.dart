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
}