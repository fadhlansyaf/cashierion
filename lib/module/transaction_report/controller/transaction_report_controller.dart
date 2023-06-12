import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../model/database/category.dart';
import 'transaction_report_dao.dart';

class TransactionReportLogic extends GetxController {
  var selectedIndex = 0.obs;
  // var categoryList = <CategoryModel>[].obs;
  var categoryCount = <int>[].obs;
  var isLoading = true.obs;
  var filter = ['Order', 'Restock'].obs;
  var selectedFilter = 0.obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   isLoading.value = true;
  //   final dao = Get.find<CategoryListDao>();
  //   categoryList = await dao.getCategoryList();
  //   for(int i=0; i<categoryList.length; i++){
  //     categoryCount.add(await dao.checkCategoryCount(categoryList[i]));
  //   }
  //   isLoading.value = false;
  //   update();
  // }

  // Future<RxList<CategoryModel>> getCategoryList() async {
  //   final dao = Get.find<CategoryListDao>();
  //   return await dao.getCategoryList();
  // }
}
