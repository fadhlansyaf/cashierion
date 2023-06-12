import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/model/database/category.dart';

import '../../../model/database/database_model.dart';
import 'transaction_history_form_dao.dart';

class TransactionHistoryFormLogic extends GetxController {
  var isEdited = false.obs;

  List<TextEditingController> textController = [];

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
            description: textController[i].text));
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
    //TODO(dhanis): snackbar success edit
  }
}
