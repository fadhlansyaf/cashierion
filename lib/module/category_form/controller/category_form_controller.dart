import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

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
}
