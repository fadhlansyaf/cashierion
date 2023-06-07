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
  late Rx<PaymentDetailModel> selectedPaymentDetail;
  var paymentDetail = <PaymentDetailModel>[].obs;
  var tax = 0.obs;
  var isOrder = true.obs;

  //variabel untuk bottomsheet
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setStatePaymentType = Rx<StateSetter?>(null);
  Rx<StateSetter?> setStatePaymentDetail = Rx<StateSetter?>(null);
  final paymentTypeController = TextEditingController();
  final paymentDetailController = TextEditingController();

  @override
  Future<void> onInit() async {
    var categoryDao = Get.find<CategoryListDao>();
    var productDao = Get.find<ProductListDao>();
    var homeDao = Get.find<HomeDao>();
    categoryList = await categoryDao.getCategoryList();
    productList = await productDao.getAllProducts();
    checkEmptyCategory();
    paymentType = await homeDao.getAllPaymentType();
    selectedPaymentType = paymentType.first.obs;
    paymentDetail = await homeDao.getPaymentDetail(selectedPaymentType.value);
    if(paymentDetail.isNotEmpty){
      selectedPaymentDetail = paymentDetail.first.obs;
    }
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

  ///Dipanggil ketika user menambahkan payment type/detail baru
  Future<void> initPayments() async {
    var homeDao = Get.find<HomeDao>();
    paymentType = await homeDao.getAllPaymentType();
    paymentDetail = await homeDao.getPaymentDetail(selectedPaymentType.value);
  }

  ///Dipanggil ketika user mengubah tipe pembayaran
  Future<void> reinitializeSelectedPaymentDetail() async {
    var homeDao = Get.find<HomeDao>();
    paymentDetail = await homeDao.getPaymentDetail(selectedPaymentType.value);
    if(paymentDetail.isNotEmpty){
      selectedPaymentDetail = paymentDetail.first.obs;
    }
  }

  Future<void> insertPaymentType() async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.insertPaymentType(PaymentTypeModel(paymentName: paymentTypeController.text));
    Get.back();
  }

  Future<void> insertPaymentDetail() async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.insertPaymentDetail(PaymentDetailModel(paymentTypeId: 1, description: paymentDetailController.text));
    Get.back();
  }

  //untuk mengecek category yg empty
  void checkEmptyCategory(){
    List<int> needToRemoved = [];
    int i=0;
    for(var e in categoryList){
      bool remove = true;
      for(var f in productList){
        if(e.id == f.productCategoryId){
          remove = false;
          break;
        }
      }
      if(remove){
        needToRemoved.add(i);
      }
      i++;
    }
    needToRemoved.sort((a, b) => b.compareTo(a),);
    for(var e in needToRemoved){
      categoryList.removeAt(e);
    }
  }
}
