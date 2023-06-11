import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/controller/transaction_history_detail_dao.dart';

import '../../../core.dart';
import '../../../model/database/category.dart';
import '../../../model/database/category.dart';
import '../../transaction_history_list/controller/transaction_history_list_dao.dart';

class TransactionHistoryDetailLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  var transactionDetailList = <TransactionDetailModel>[].obs;
  var productList = <ProductModel>[].obs;
  var listController = Get.find<TransactionHistoryListLogic>();
  late Rx<TransactionModel> transaction = listController.selectedTransaction.value!.obs;
  var isLoading = true.obs;
  var tax = 0.0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    var dao = Get.find<TransactionHistoryDetailDao>();
    transaction = await dao.refreshTransaction(listController.selectedTransaction.value!);
    transactionDetailList.value = await dao.getTransactionDetails(listController.selectedTransaction.value!);
    productList.clear();
    for(var e in transactionDetailList){
      productList.add((await dao.getProduct(e)).copyWith(quantity: e.quantity.obs));
    }
    isLoading.value = false;
  }

  Future<void> deleteTransaction()async {
    final dao = Get.find<TransactionHistoryDetailDao>();
    var listController = Get.find<TransactionHistoryListLogic>();
    dao.deleteTransaction(listController.selectedTransaction.value!);
    Get.back();
  }
}
