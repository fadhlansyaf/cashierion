import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/category_list/controller/category_list_dao.dart';
import 'package:cashierion/module/product_list/controller/product_list_dao.dart';

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
