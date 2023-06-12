import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/category_detail/controller/category_detail_dao.dart';

import '../../category_list/controller/category_list_dao.dart';
import 'category_detail_controller.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailLogic());
    Get.lazyPut(() => CategoryDetailDao());
    Get.lazyPut(() => CategoryListDao());
  }
}
