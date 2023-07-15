import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/model/database/category.dart';

import '../../../model/database/database_model.dart';
import '../../../utils/preferences.dart';
import 'transaction_history_form_dao.dart';

class TransactionHistoryFormLogic extends GetxController {
  var isEdited = false.obs;
  ///% tax
  var tax = 0.obs;
  ///Total tax setelah dihitung
  var taxTotal = 0.0.obs;
  ///Total semua item dan tax
  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    tax.value = Preferences.getInstance().getInt(SharedPreferenceKey.TAX) ?? 0;
    super.onInit();
  }

  ///Menghtiung total tax
  void countTotal(List<ProductModel> products, bool isOrder) {
    double total = 0;
    for (var e in products) {
      if (isOrder) {
        total += e.sellingPrice * e.quantity.value;
      } else {
        total += e.price * e.quantity.value;
      }
    }
    taxTotal.value = total * (tax / 100);
    totalAmount.value = total;
  }

  Future<void> editTransaction(List<TransactionDetailModel> transactionDetail,
      List<ProductModel> products, TransactionModel transaction) async {
    List<TransactionDetailModel> editedTransactionDetail = [];
    double newTotal = 0;
    var productDao = Get.find<ProductFormDao>();
    for (int i = 0; i < transactionDetail.length; i++) {
      if (products[i].quantity.value != 0) {
        editedTransactionDetail.add(TransactionDetailModel(
            transactionId: transactionDetail[i].transactionId,
            productId: transactionDetail[i].productId,
            quantity: products[i].quantity.value,
            description: products[i].transactionDesc));
      }
      productDao.editItem(products[i].copyWith(
          stock: transaction.invoice.startsWith('CO')
              ? products[i].stock +
              (transactionDetail[i].quantity - products[i].quantity.value)
              : products[i].stock -
              (transactionDetail[i].quantity -
                  products[i].quantity.value)));
      newTotal += products[i].quantity.value *
          (transaction.invoice.startsWith('CO')
              ? products[i].sellingPrice
              : products[i].price);
    }
    var dao = Get.find<TransactionHistoryFormDao>();
    var updatedTransaction = transaction.copyWith(sales: newTotal);
    await dao.editTransactionDetails(
        editedTransactionDetail, updatedTransaction);
    isEdited.value = true;
    Get.back();
    Get.snackbar(
      'Success',
      'Transaction has been successfully Edited',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.only(bottom: 120.0),
    );
  }
}
