import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/model/database/category.dart';
import 'package:cashierion/module/home/controller/home_binding.dart';
import 'package:cashierion/utils/preferences.dart';

import 'register_dao.dart';

class RegisterLogic extends GetxController {
  final textController = TextEditingController();

  ///Menyimpan data data register toko
  void registerStore(){
    Preferences.getInstance().setString(SharedPreferenceKey.STORE_NAME, textController.text);
    Preferences.getInstance().setInt(SharedPreferenceKey.TAX, 10);
    Get.delete<RegisterLogic>();
    Get.off(() => HomePage(), binding: HomeBinding());
  }
}
