import 'package:get/get.dart';

import 'stock_report_controller.dart';

class StockReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockReportLogic());
  }
}
