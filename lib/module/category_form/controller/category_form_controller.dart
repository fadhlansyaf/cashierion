import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/model/database/category.dart';

import 'category_form_dao.dart';

class CategoryFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  /// 0 = Category Name
  ///
  /// 1 = Description
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController()
  ];

  Future<void> insertOrUpdateCategory([CategoryModel? category]) async {
    var dao = Get.find<CategoryFormDao>();
    if(category == null) {
      await dao.insertCategory(CategoryModel(
          name: textController[0].text, description: textController[1].text));
    }else{
      await dao.editCategory(CategoryModel(id: category.id,
          name: textController[0].text, description: textController[1].text));
      Get.back();
    }
    //Clear text
    for(var e in textController){
      e.text = '';
    }
    Get.back();
  }
}
