import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/product_detail/controller/product_detail_dao.dart';

import 'product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailLogic());
    Get.lazyPut(() => ProductDetailDao());
  }
}
