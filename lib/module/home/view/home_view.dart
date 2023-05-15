import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/purchase_order/view/purchase_order_view.dart';

import '../widget/dashboard_view.dart';
import '../widget/profile_view.dart';
import '../widget/purchase_order_nav.dart';
import '../widget/sales_transaction_nav.dart';
import '../controller/home_controller.dart';
import '../widget/sales_transaction_view.dart';

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
            children: [DashboardView(), PurchaseOrderNavView(), SalesTransactionNavView(), ProfileView()],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.grey[700],
            unselectedItemColor: Colors.grey[500],
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                label: "Dashboard",
                icon: Icon(
                  MdiIcons.viewDashboard,
                ),
              ),
              BottomNavigationBarItem(
                label: "Purchase Order",
                icon: Icon(
                  Icons.check_box,
                ),
              ),
              BottomNavigationBarItem(
                label: "Sales Transaction",
                icon: Icon(
                  Icons.sell,
                ),
              ),
              BottomNavigationBarItem(
                label: "Me",
                icon: Icon(
                  Icons.person,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void requestPermission() async{
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
