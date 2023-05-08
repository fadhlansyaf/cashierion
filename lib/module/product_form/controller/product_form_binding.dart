import 'package:get/get.dart';

import 'product_form_controller.dart';

class ProductFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductFormLogic());
  }
}
