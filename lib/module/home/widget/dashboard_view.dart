import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/category_list/controller/category_list_binding.dart';
import 'package:pos_app_skripsi/module/product_list/controller/product_list_binding.dart';
import 'package:pos_app_skripsi/module/purchase_order/controller/purchase_order_binding.dart';
import 'package:pos_app_skripsi/module/sales_transaction/controller/sales_transaction_binding.dart';
import 'package:pos_app_skripsi/module/stock_report/controller/stock_report_binding.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../sales_report/controller/sales_report_binding.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var controller = Get.find<HomeLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.notifications,
          //     size: 24.0,
          //   ),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.chat,
          //     size: 24.0,
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    List menus = [
                      {
                        "icon": "assets/icons8-product-32.png",
                        "label": "Products\n",
                        "onTap": () => Get.to(ProductListPage(),
                            binding: ProductListBinding())?.then((value) => controller.onInit()),
                      },
                      {
                        "icon": "assets/icons8-category-32.png",
                        "label": "Categories\n",
                        "onTap": () => Get.to(CategoryListPage(),
                            binding: CategoryListBinding())?.then((value) => controller.onInit()),
                      },
                      {
                        "icon": "assets/icons8-transaction-32.png",
                        "label": "Transaction\nDetail",
                        "onTap": () => {}
                      },
                      {
                        "icon": "assets/icons8-report-32.png",
                        "label": "Transaction\nReport",
                        "onTap": () => Get.to(StockReportPage(),
                            binding: StockReportBinding())?.then((value) => controller.onInit()),
                      },
                    ];

                    return Wrap(
                      children: List.generate(
                        menus.length,
                        (index) {
                          var item = menus[index];

                          var size = constraint.biggest.width / 4;

                          return SizedBox(
                            width: size,
                            height: size,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: ColorTheme.COLOR_GREY,
                                animationDuration:
                                    const Duration(milliseconds: 1000),
                                backgroundColor: Colors.transparent,
                                splashFactory: InkSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                elevation: 0.0,
                              ),
                              onPressed: () => item["onTap"](),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    item["icon"],
                                    width: 30.0,
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    "${item["label"]}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 9.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Prediction",
                        style: TextStyle(
                            color: ColorTheme.COLOR_WHITE,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 150.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Financial Statement",
                    style: TextStyle(
                        color: ColorTheme.COLOR_WHITE,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sales",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_GREY,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Rp 0",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_WHITE,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expenditure",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_GREY,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Rp 0",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_WHITE,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today's Transactions",
                    style: TextStyle(
                        color: ColorTheme.COLOR_WHITE,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transaction Totals",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_GREY,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_WHITE,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Product Sold",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_GREY,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      color: ColorTheme.COLOR_WHITE,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
