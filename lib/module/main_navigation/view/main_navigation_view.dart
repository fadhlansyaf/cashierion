import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import '../controller/main_navigation_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter/material.dart';



class MainNavigationView extends StatefulWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [
            DashboardView(),
            SalesReportView(),
            ProfileView()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          selectedItemColor: Colors.grey[700],
          unselectedItemColor: Colors.grey[500],
          onTap: (index) {
            controller.selectedIndex = index;
            controller.setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: "Dashboard",
              icon: Icon(
                MdiIcons.viewDashboard,
              ),
            ),
            BottomNavigationBarItem(
              label: "Order",
              icon: Icon(
                Icons.list,
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
    );
  }

  @override
  State<MainNavigationView> createState() => MainNavigationController();
}
