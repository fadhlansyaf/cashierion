import 'package:get/get.dart';
import 'package:cashierion/module/transaction_report/controller/transaction_report_dao.dart';

import 'transaction_report_controller.dart';

class TransactionReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionReportLogic());
    Get.lazyPut(() => TransactionReportDao());
  }
}
