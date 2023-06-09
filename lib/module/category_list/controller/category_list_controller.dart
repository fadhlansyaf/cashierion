import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/database/category.dart';
import 'category_list_dao.dart';

class CategoryListLogic extends GetxController {
  var selectedIndex = 0.obs;
  var categoryList = <CategoryModel>[].obs;
  var categoryCount = <int>[].obs;
  var isLoading = true.obs;
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setState = Rx<StateSetter?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    update();
    final dao = Get.find<CategoryListDao>();
    categoryList.value = await dao.getCategoryList();
    categoryCount.clear();
    for(int i=0; i<categoryList.length; i++){
      categoryCount.add(await dao.checkCategoryCount(categoryList[i]));
    }
    isLoading.value = false;
    update();
  }

  Future<RxList<CategoryModel>> getCategoryList() async {
    final dao = Get.find<CategoryListDao>();
    return await dao.getCategoryList();
  }

  
}
