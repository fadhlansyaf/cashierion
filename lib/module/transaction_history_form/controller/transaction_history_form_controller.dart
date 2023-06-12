import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/model/database/category.dart';

import '../../../model/database/database_model.dart';
import 'transaction_history_form_dao.dart';

class TransactionHistoryFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

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
    Get.back();
    //TODO(dhanis): snackbar success edit
    Get.snackbar(
      'Success',
      'Transaction has been successfully Edited',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.only(bottom: 120.0),
    );
  }

  // Future<void> insertOrUpdateCategory([CategoryModel? category]) async {
  //   var dao = Get.find<CategoryFormDao>();
  //   if(category == null) {
  //     await dao.insertCategory(CategoryModel(
  //         name: textController[0].text, description: textController[1].text));
  //   }else{
  //     await dao.editCategory(CategoryModel(id: category.id,
  //         name: textController[0].text, description: textController[1].text));
  //     Get.back();
  //   }
  //   //Clear text
  //   for(var e in textController){
  //     e.text = '';
  //   }
  //   Get.back();
  // }
}
