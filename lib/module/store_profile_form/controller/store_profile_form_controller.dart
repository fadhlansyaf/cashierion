import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/model/database/category.dart';
import 'package:cashierion/utils/preferences.dart';

import 'store_profile_form_dao.dart';

class StoreProfileFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  /// 0 = Store Name
  ///
  /// 1 = Phone Number
  ///
  /// 2 = Store Address
  ///
  /// 3 = Description
  List<TextEditingController> textController = List.generate(4, (index) => TextEditingController());
  var prefs = Preferences.getInstance();


  @override
  void onInit() {
    super.onInit();
    //Initialize controller jika sudah ada data pada shared preferences
    textController[0].text = prefs.getString(SharedPreferenceKey.STORE_NAME) ?? '';
    textController[1].text = prefs.getString(SharedPreferenceKey.PHONE_NUMBER) ?? '';
    textController[2].text = prefs.getString(SharedPreferenceKey.STORE_ADDRESS) ?? '';
    textController[3].text = prefs.getString(SharedPreferenceKey.DESCRIPTION) ?? '';
  }

  ///Menyimpan data toko pada shared preferences
  void saveStoreProfile(){
    prefs.setString(SharedPreferenceKey.STORE_NAME, textController[0].text);
    prefs.setString(SharedPreferenceKey.PHONE_NUMBER, textController[1].text);
    prefs.setString(SharedPreferenceKey.STORE_ADDRESS, textController[2].text);
    prefs.setString(SharedPreferenceKey.DESCRIPTION, textController[3].text);
    Get.back();
  }
}
