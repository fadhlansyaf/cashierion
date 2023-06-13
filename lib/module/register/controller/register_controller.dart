import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/model/database/category.dart';
import 'package:pos_app_skripsi/module/home/controller/home_binding.dart';
import 'package:pos_app_skripsi/utils/preferences.dart';

import 'register_dao.dart';

class RegisterLogic extends GetxController {
  final textController = TextEditingController();

  void registerStore(){
    Preferences.getInstance().setString(SharedPreferenceKey.STORE_NAME, textController.text);
    Preferences.getInstance().setInt(SharedPreferenceKey.TAX, 10);
    Get.delete<RegisterLogic>();
    Get.off(() => HomePage(), binding: HomeBinding());
  }
}
