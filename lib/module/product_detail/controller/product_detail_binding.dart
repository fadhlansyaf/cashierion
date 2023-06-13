import 'package:get/get.dart';
import 'package:cashierion/module/product_detail/controller/product_detail_dao.dart';

import '../../category_list/controller/category_list_dao.dart';
import 'product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailLogic());
    Get.lazyPut(() => ProductDetailDao());
    Get.lazyPut(() => CategoryListDao());
  }
}
