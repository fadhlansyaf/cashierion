import 'package:get/get.dart';

import 'sales_report_controller.dart';

class SalesReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesReportLogic());
  }
}
