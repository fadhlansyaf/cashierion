import 'package:get/get.dart';
import 'package:cashierion/module/transaction_history_form/controller/transaction_history_form_dao.dart';

import '../../../core.dart';
import 'transaction_history_form_controller.dart';

class TransactionHistoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryFormLogic());
    Get.lazyPut(() => TransactionHistoryFormDao());
    Get.lazyPut(() => ProductFormDao());
  }
}
