import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/controller/transaction_history_detail_dao.dart';

import '../../../model/database/category.dart';
import '../../../model/database/category.dart';
import '../../transaction_history_list/controller/transaction_history_list_dao.dart';

class TransactionHistoryDetailLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // var categoryList = <CategoryModel>[].obs;
  var isLoading = true.obs;

  /// 0 = Category Name
  ///
  /// 1 = Price
  ///
  /// 2 = Description
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   var categoryDao = Get.find<CategoryListDao>();
  //   categoryList = await categoryDao.getCategoryList();
  //   isLoading.value = false;
  //   update();
  // }

  // Future<void> deleteCategory(CategoryModel category)async {
  //   final dao = Get.find<CategoryDetailDao>();
  //   dao.deleteCategory(category);
  //   Get.back();
  // }
}
