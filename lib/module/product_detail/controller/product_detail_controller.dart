import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/module/product_detail/controller/product_detail_dao.dart';

import '../../../model/database/category.dart';
import '../../../model/database/product.dart';
import '../../category_list/controller/category_list_dao.dart';

class ProductDetailLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  var categoryList = <CategoryModel>[].obs;
  var isLoading = true.obs;

  /// 0 = Product Name
  ///
  /// 1 = Price
  ///
  /// 2 = Description
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    var categoryDao = Get.find<CategoryListDao>();
    categoryList = await categoryDao.getCategoryList();
    isLoading.value = false;
    update();
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<bool?> deleteItem(ProductModel product)async {
    final dao = Get.find<ProductDetailDao>();
    var success = await dao.deleteItem(product);
    return success;
  }
}
