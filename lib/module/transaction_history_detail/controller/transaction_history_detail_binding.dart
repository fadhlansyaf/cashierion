import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/controller/transaction_history_detail_dao.dart';

import '../../transaction_history_list/controller/transaction_history_list_dao.dart';
import 'transaction_history_detail_controller.dart';

class TransactionHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryDetailLogic());
    Get.lazyPut(() => TransactionHistoryDetailDao());
    Get.lazyPut(() => TransactionHistoryListDao());
  }
}
