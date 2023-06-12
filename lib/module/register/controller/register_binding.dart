import 'package:get/get.dart';
import 'package:pos_app_skripsi/module/register/controller/register_dao.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterLogic());
    Get.lazyPut(() => RegisterDao());
  }
}
