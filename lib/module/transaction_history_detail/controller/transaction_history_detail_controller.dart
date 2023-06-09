import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/module/transaction_history_detail/controller/transaction_history_detail_dao.dart';
import 'package:cashierion/utils/constant.dart';
import 'package:cashierion/utils/preferences.dart';

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
  var tax = 0.obs;
  var taxTotal = 0.0.obs;
  var totalAmount = 0.0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    tax.value = Preferences.getInstance().getInt(SharedPreferenceKey.TAX) ?? 0;
    var dao = Get.find<TransactionHistoryDetailDao>();
    try {
      transaction = await dao.refreshTransaction(listController.selectedTransaction.value!);
    } catch (e) {
      print(e);
    }
    transactionDetailList.value = await dao.getTransactionDetails(listController.selectedTransaction.value!);
    productList.clear();
    for(var e in transactionDetailList){
      try {
        productList.add((await dao.getProduct(e)).copyWith(quantity: e.quantity.obs, transactionDesc: e.description));
      } catch (e) {
        print(e);
      }
    }
    countTotal(productList, transaction.value.invoice.startsWith('CO'));
    isLoading.value = false;
  }

  Future<void> deleteTransaction()async {
    final dao = Get.find<TransactionHistoryDetailDao>();
    var listController = Get.find<TransactionHistoryListLogic>();
    await dao.deleteTransaction(listController.selectedTransaction.value!);
    Get.back();
  }

  void countTotal(List<ProductModel> products, bool isOrder) {
    double total = 0;
    for (var e in products) {
      if (isOrder) {
        total += e.sellingPrice * e.quantity.value;
      }else{
        total += e.price * e.quantity.value;
      }
    }
    taxTotal.value = total * (tax/100);
    totalAmount.value = total;
  }
}
