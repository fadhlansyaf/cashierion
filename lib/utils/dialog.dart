import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/controller/transaction_history_detail_controller.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

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
      controller.deleteCategory(category);
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
      controller.deleteItem(product);
    }
  }

  static void deletetransactionHistoryDialog(
    BuildContext context,
    TransactionHistoryDetailLogic controller,
    // TransactionModel transaction,
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
      // controller.deleteItem(product);
    }
  }

  static void productQuantityDialog(
      BuildContext context, List<ProductModel> products, int index
      // TransactionModel transaction,
      ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quantity'),
        content: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            // onSaved: onSaved,
            keyboardType: TextInputType.number,
            // controller: controller,
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
      // controller.deleteItem(product);
    }
  }
}
