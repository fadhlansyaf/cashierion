import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/purchase_order/view/purchase_order_view.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../widget/dashboard_view.dart';
import '../widget/profile_view.dart';
import '../widget/transaction_nav.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeLogic>();
    requestPermission();

    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex.value,
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              DashboardView(),
              TransactionNavView(),
              // SalesTransactionNavView(),
              ProfileView()
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: ColorTheme.COLOR_PRIMARY,
            unselectedItemColor: ColorTheme.COLOR_WHITE,
            backgroundColor: ColorTheme.COLOR_CARD,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  label: "Dashboard",
                  // icon: new Image.asset("assets/icons8-home-32.png")
                  icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Transaction",
                  // icon: new Image.asset("assets/icons8-order-32.png")
                  icon: Icon(Icons.list_alt_outlined)),
              BottomNavigationBarItem(
                  label: "Store",
                  // icon: new Image.asset("assets/icons8-store-32.png")
                  icon: Icon(Icons.store_mall_directory)),
            ],
          ),
        ),
      ),
    );
  }
}

void requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
