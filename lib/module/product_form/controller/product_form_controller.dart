import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/category.dart';

import '../../../core.dart';
import '../../../model/database/product.dart';
import 'product_form_dao.dart';

class ProductFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  Uint8List? selectedImageBytes;
  ///Kategori awal yang terpilih
  var initialCategory = CategoryModel(name: '', description: '');
  late Rx<CategoryModel> selectedCategory = initialCategory.obs;

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

  @override
  Future<void> onInit() async {
    final categoryController = Get.find<CategoryListLogic>();
    var categoryList = await categoryController.getCategoryList();
    if (selectedCategory.value == initialCategory) {
      //initialize selected kategori menjadi kategori pertama pada list kategori
      selectedCategory = categoryList.first.obs;
      textController[5].text = selectedCategory.value.name;
    }
    super.onInit();
  }

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

  Future<void> insertOrEditProduct([ProductModel? product]) async {
    final dao = Get.find<ProductFormDao>();
    var compressed = await _compressImage();
    if(product == null) {
      await dao.insertItem(ProductModel(
          name: textController[0].text,
          price: double.parse(textController[1].text),
          sellingPrice: double.parse(textController[2].text),
          stock: int.parse(textController[3].text),
          description: textController[4].text,
          image: compressed,
          productCategoryId: selectedCategory.value.id));
    }else{
      await dao.editItem(ProductModel(
          id: product.id,
          name: textController[0].text,
          price: double.parse(textController[1].text),
          sellingPrice:
          double.parse(textController[2].text),
          stock: int.parse(textController[3].text),
          description: textController[4].text,
          image: compressed,
          productCategoryId: selectedCategory.value.id));
      Get.back();
    }
    Get.back();
  }

  ///Digunakan untuk melakukan kompresi gambar
  Future<String> _compressImage() async{
    if(selectedImageBytes != null) {
      var compressed = await FlutterImageCompress.compressWithList(
          selectedImageBytes!, quality: 10);
      return base64Encode(compressed.toList());
    }else{
      return '';
    }
  }
}
