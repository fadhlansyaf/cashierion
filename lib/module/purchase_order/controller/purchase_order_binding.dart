import 'package:get/get.dart';

import 'purchase_order_controller.dart';

class PurchaseOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseOrderController());
  }
}
