import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/category_list/controller/category_list_dao.dart';

import 'category_list_controller.dart';

class CategoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryListLogic());
    Get.lazyPut(() => CategoryListDao());
  }
}
