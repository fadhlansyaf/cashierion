import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/category.dart';

class ProductFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  Uint8List? selectedImageBytes;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  /// 0 = Product Name
  ///
  /// 1 = Price
  ///
  /// 2 = Selling Price
  ///
  /// 3 = Stock
  ///
  /// 4 = Description
  ///
  /// 5 = Category (Text)
  List<TextEditingController> textController = List.generate(6, (index) => TextEditingController());

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImageBytes = await pickedFile.readAsBytes();
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
}
