import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/transaction_history_list/controller/transaction_history_list_dao.dart';

import 'transaction_history_list_controller.dart';

class TransactionHistoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryListLogic());
    Get.lazyPut(() => TransactionHistoryListDao());
  }
}
