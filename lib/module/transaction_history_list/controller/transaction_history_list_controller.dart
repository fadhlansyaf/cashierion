import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

// import '../../../model/database/category.dart';
import 'transaction_history_list_dao.dart';

class TransactionHistoryListLogic extends GetxController {
  var selectedIndex = 0.obs;
  var transactionList = <TransactionModel>[].obs;
  var transactionCount = <int>[].obs;
  var isLoading = true.obs;
  var now = DateTime.now();
  late var startDate = DateTime(now.year, now.month, now.day, 0, 0).obs;
  late var endDate = DateTime(now.year, now.month, now.day, 23, 59).obs;
  var filter = ['Order', 'Restock'].obs;
  var selectedFilter = 0.obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    var dao = Get.find<TransactionHistoryListDao>();
    transactionList = await dao.getTransactionList(startDate.value, endDate.value, selectedFilter.value);
    for(var e in transactionList){
      transactionCount.add(await dao.checkTransactionDetailCount(e));
    }
    super.onInit();
  }

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
