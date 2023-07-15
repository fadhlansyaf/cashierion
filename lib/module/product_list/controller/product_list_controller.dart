import 'package:get/get.dart';
import 'package:cashierion/module/product_list/controller/product_list_dao.dart';

import '../../../model/database/product.dart';

class ProductListLogic extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoaded = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    products.clear();
    products.value = await ProductListDao().getAllProducts();
    isLoaded.value = true;
  }
}
