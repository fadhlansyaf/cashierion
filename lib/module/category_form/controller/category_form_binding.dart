import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/category_form/controller/category_form_dao.dart';

import 'category_form_controller.dart';

class CategoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryFormLogic());
    Get.lazyPut(() => CategoryFormDao());
  }
}
