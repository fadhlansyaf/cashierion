import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/store_profile_form/controller/store_profile_form_dao.dart';

import 'store_profile_form_controller.dart';

class StoreProfileFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreProfileFormLogic());
    Get.lazyPut(() => StoreProfileFormDao());
  }
}
