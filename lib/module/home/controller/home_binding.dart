import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/category_list/controller/category_list_dao.dart';
import 'package:pos_app_skripsi/module/product_list/controller/product_list_dao.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => HomeDao());
    Get.lazyPut(() => ProductListLogic());
    Get.lazyPut(() => ProductListDao());
    Get.lazyPut(() => CategoryListLogic());
    Get.lazyPut(() => CategoryListDao());
  }
}
