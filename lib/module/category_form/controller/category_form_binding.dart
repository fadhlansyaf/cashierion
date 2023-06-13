import 'package:get/get.dart';
import 'package:cashierion/module/category_form/controller/category_form_dao.dart';

import 'category_form_controller.dart';

class CategoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryFormLogic());
    Get.lazyPut(() => CategoryFormDao());
  }
}
