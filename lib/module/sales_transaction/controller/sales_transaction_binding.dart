import 'package:get/get.dart';

import 'sales_transaction_controller.dart';

class SalesTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesTransactionController());
  }
}
