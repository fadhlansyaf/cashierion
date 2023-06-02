import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/database/category.dart';
import 'category_list_dao.dart';

class CategoryListLogic extends GetxController {
  var selectedIndex = 0.obs;
  var categoryList = <CategoryModel>[].obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    final dao = Get.find<CategoryListDao>();
    categoryList = await dao.getCategoryList();
    var timer = Timer.periodic(Duration(seconds: 5), (timer) {
      selectedIndex.value++;
      if(setState.value != null){
        setState.value!((){});
      }
    });
  }
}
