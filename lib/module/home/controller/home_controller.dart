import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';

import '../../../model/database/database_model.dart';
import '../../category_list/controller/category_list_dao.dart';
import '../../product_list/controller/product_list_dao.dart';

class HomeLogic extends GetxController {
  var selectedIndex = 0.obs;
  var categoryList = <CategoryModel>[].obs;
  var productList = <ProductModel>[].obs;
  late Rx<PaymentTypeModel> selectedPaymentType;
  var paymentType = <PaymentTypeModel>[].obs;
  var tax = 0.obs;
  var isOrder = true.obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    var categoryDao = Get.find<CategoryListDao>();
    var productDao = Get.find<ProductListDao>();
    var homeDao = Get.find<HomeDao>();
    categoryList = await categoryDao.getCategoryList();
    productList = await productDao.getAllProducts();
    paymentType = await homeDao.getAllPaymentType();
    selectedPaymentType = paymentType.first.obs;
    super.onInit();
  }

  ///isOrder = false berarti restock
  double countTotal(List<ProductModel> products){
    double total = 0;
    for(var e in products){
      if(isOrder.value) {
        total += e.sellingPrice * e.quantity.value;
      }
    }
    return total;
  }
}
