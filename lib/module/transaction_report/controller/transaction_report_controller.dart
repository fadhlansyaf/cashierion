import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../model/database/category.dart';
import '../../../model/database/database_model.dart';
import '../../../utils/preferences.dart';
import 'transaction_report_dao.dart';

class TransactionReportLogic extends GetxController {
  var reportList = <TransactionReportModel>[].obs;
  var isLoading = true.obs;
  var now = DateTime.now();
  late var startDate = DateTime(now.year, now.month, now.day, 0, 0).obs;
  late var endDate = DateTime(now.year, now.month, now.day, 23, 59).obs;
  var filter = ['Order', 'Restock'].obs;
  var selectedFilter = 0.obs;
  //TODO(dhanis): masukin tax & totalAmount
  ///% Taxnya
  var tax = 0.obs;
  ///Total tax setelah dijumlah dengan produk
  var taxTotal = 0.0.obs;
  ///Jumlah total tax dan total
  var totalAmount = 0.0.obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    reportList.clear();
    tax.value = Preferences.getInstance().getInt(SharedPreferenceKey.TAX) ?? 0;
    var dao = Get.find<TransactionReportDao>();
    reportList.value = await dao.getTotalQuantity(startDate.value, endDate.value, selectedFilter.value);
    countTotal(reportList, selectedFilter.value == 0);
    isLoading.value = false;
    update();
    super.onInit();
  }

  void countTotal(List<TransactionReportModel> reportList, bool isOrder) {
    double total = 0;
    for (var e in reportList) {
      if (isOrder) {
        total += e.productSellingPrice * e.totalQuantity;
      }else{
        total += e.productPrice * e.totalQuantity;
      }
    }
    taxTotal.value = total * (tax/100);
    totalAmount.value = total;
  }
}
