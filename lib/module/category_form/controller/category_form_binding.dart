import 'package:get/get.dart';

import 'category_form_controller.dart';

class CategoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryFormLogic());
  }
}
