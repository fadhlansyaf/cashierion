import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/transaction_history_detail/controller/transaction_history_detail_controller.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../model/database/category.dart';
import '../model/database/database_model.dart';
import '../module/product_form/widget/search_appbar.dart';
import 'no_overscroll.dart';
import '/widgets/custom_text_field.dart';

class Dialogs {
  static void deleteCategoryDialog(
    BuildContext context,
    CategoryDetailLogic controller,
    CategoryModel category,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.deleteCategory(category).then((success) {
        if (success != null) {
          if (success) {
            Get.back();
          } else {
            //TODO(dhanis): snackbar error gagal karena masih ada produk
            Get.snackbar(
                'Cannot delete category!', 'Category is already in use',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        } else {
          //TODO(dhanis): unknown error (Tulisanya An error occurred, please try again later gitu aja mungkin)
          Get.snackbar(
              'unknown error', 'An error occurred, please try again later',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      });
    }
  }

  static void deleteProductsDialog(
    BuildContext context,
    ProductDetailLogic controller,
    ProductModel product,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.deleteItem(product).then((success) {
        if (success != null) {
          if (success) {
            Get.back();
          } else {
            //TODO(dhanis): snackbar error gagal karena masih ada transaksi detail
            Get.snackbar(
                'Cannot delete product!', 'Product is already in transaction',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        } else {
          //TODO(dhanis): unknown error (Tulisanya An error occurred, please try again later gitu aja mungkin)
          Get.snackbar(
              'unknown error', 'An error occurred, please try again later',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      });
    }
  }

  static void deleteTransactionHistoryDialog(
    BuildContext context,
    TransactionHistoryDetailLogic controller,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.deleteTransaction();
    }
  }

  static void deletePaymentTypeDialog(BuildContext context,
      HomeLogic controller, PaymentTypeModel paymentType) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.deletePaymentType(paymentType);
    }
  }

  static void deletePaymentMethodDialog(
    BuildContext context,
    HomeLogic controller,
    PaymentDetailModel paymentDetail,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.deletePaymentDetail(paymentDetail);
    }
  }

  static void deleteAllDataDialog(
    BuildContext context,
    HomeLogic controller,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete all data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.clearAllData();
      Get.snackbar(
        'Success',
        'All data has been successfully deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 20.0),
      );
    }
  }

  static void productQuantityDialog(
      BuildContext context, ProductModel product) async {
    final quantityController = TextEditingController()
      ..text = product.quantity.value.toString();
    final descController = TextEditingController()
      ..text = product.transactionDesc;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quantity & Description'),
        content: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                // onSaved: onSaved,
                keyboardType: TextInputType.number,
                controller: quantityController,
                // onTap: onTap,
                // readOnly: onTap != null,
                cursorColor: ColorTheme.COLOR_PRIMARY,
                decoration: InputDecoration(
                  // helperText: helperText,
                  labelText: "Quantity",
                  labelStyle: TextStyle(color: ColorTheme.COLOR_GREY),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: ColorTheme.COLOR_CARD,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorTheme.COLOR_WHITE),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorTheme.COLOR_PRIMARY),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.25,
                    ),
                  ),
                  // suffixIcon: onTap != null ? suffixIcon : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                // onSaved: onSaved,
                keyboardType: TextInputType.text,
                controller: descController,
                // onTap: onTap,
                // readOnly: onTap != null,
                cursorColor: ColorTheme.COLOR_PRIMARY,
                decoration: InputDecoration(
                  // helperText: helperText,
                  labelText: "Description",
                  labelStyle: TextStyle(color: ColorTheme.COLOR_GREY),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: ColorTheme.COLOR_CARD,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorTheme.COLOR_WHITE),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorTheme.COLOR_PRIMARY),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.25,
                    ),
                  ),
                  // suffixIcon: onTap != null ? suffixIcon : null,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Ok',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      product.quantity.value = int.parse(quantityController.text);
      product.transactionDesc = descController.text;
    }
  }

  static void addTaxDialog(BuildContext context, HomeLogic controller) async {
    var taxController = TextEditingController()
      ..text = controller.tax.toString();
    final _formKey = GlobalKey<FormState>();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Tax'),
        content: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  // onSaved: onSaved,
                  keyboardType: TextInputType.number,
                  controller: taxController,
                  // onTap: onTap,
                  // readOnly: onTap != null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Input can\'t be empty';
                    }

                    return null;
                  },
                  cursorColor: ColorTheme.COLOR_PRIMARY,
                  decoration: InputDecoration(
                    // helperText: helperText,
                    labelText: "Tax",
                    labelStyle: TextStyle(color: ColorTheme.COLOR_GREY),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: ColorTheme.COLOR_CARD,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.COLOR_WHITE),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.25,
                      ),
                    ),
                    // suffixIcon: onTap != null ? suffixIcon : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      controller.setTax(
          taxController.text.isNotEmpty ? int.parse(taxController.text) : 0);
    }
  }

  static void predictionInfoDialog(
    BuildContext context,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About prediction'),
        content: const Text(
            'If the data is still less than 2 years, then there will be data manipulation. Predictive data can be seen according to the data that has been entered.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
              style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
            ),
          ),
        ],
      ),
    );
  }
}
