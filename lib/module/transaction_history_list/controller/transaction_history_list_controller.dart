import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/model/database/database_model.dart';

// import '../../../model/database/category.dart';
import 'transaction_history_list_dao.dart';

class TransactionHistoryListLogic extends GetxController {
  var transactionList = <TransactionModel>[].obs;
  var transactionCount = <int>[].obs;
  var isLoading = true.obs;
  ///now DateTime
  var now = DateTime.now();
  late var startDate = DateTime(now.year, now.month, now.day, 0, 0).obs;
  late var endDate = DateTime(now.year, now.month, now.day, 23, 59).obs;
  ///Pilihan untuk filter order/restock
  var filter = ['Order', 'Restock'].obs;
  ///Index pilihan filter pada [filter]
  var selectedFilter = 0.obs;
  var selectedTransaction = Rx<TransactionModel?>(null);
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    transactionList.clear();
    var dao = Get.find<TransactionHistoryListDao>();
    transactionList.value = await dao.getTransactionList(startDate.value, endDate.value, selectedFilter.value);
    transactionCount.clear();
    for(var e in transactionList){
      //Menambahkan transactionCount untuk masing masing transaction
      transactionCount.add(await dao.checkTransactionDetailCount(e));
    }
    isLoading.value = false;
    //Mengupdate ui
    update();
    super.onInit();
  }
}
