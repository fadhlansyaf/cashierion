import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/product_list/controller/product_list_dao.dart';

import '../../../model/database/products.dart';

class ProductListLogic extends GetxController {
  var selectedIndex = 0.obs;
  var products = <ProductsModel>[].obs;
  var isLoaded = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    products.value.clear();
    products.value = await ProductListDao().getAllItem();
    isLoaded.value = true;
  }
}
