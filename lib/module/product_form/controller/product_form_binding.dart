import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';


import '../../category_form/controller/category_form_controller.dart';
import '../../category_list/controller/category_list_controller.dart';
import '../../category_list/controller/category_list_dao.dart';
import 'product_form_controller.dart';

class ProductFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductFormLogic());
    Get.lazyPut(() => ProductFormDao());
    Get.lazyPut(() => CategoryListLogic());
    Get.lazyPut(() => CategoryListDao());
    Get.lazyPut(() => CategoryFormLogic());
  }
}
