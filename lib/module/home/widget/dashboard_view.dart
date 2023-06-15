import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/category_list/controller/category_list_binding.dart';
import 'package:cashierion/module/product_list/controller/product_list_binding.dart';
import 'package:cashierion/module/transaction_history_list/controller/transaction_history_list_binding.dart';
import 'package:cashierion/module/transaction_report/controller/transaction_report_binding.dart';
import 'package:cashierion/module/transaction_report/view/transaction_report_page.dart';
import 'package:cashierion/theme/theme_constants.dart';
import 'package:cashierion/utils/helper.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
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
                                binding: ProductListBinding())
                            ?.then((value) => controller.onInit()),
                      },
                      {
                        "icon": "assets/icons8-category-32.png",
                        "label": "Categories\n",
                        "onTap": () => Get.to(CategoryListPage(),
                                binding: CategoryListBinding())
                            ?.then((value) => controller.onInit()),
                      },
                      {
                        "icon": "assets/icons8-transaction-32.png",
                        "label": "Transaction\nHistory",
                        "onTap": () => Get.to(TransactionHistoryListPage(),
                                binding: TransactionHistoryListBinding())
                            ?.then((value) => controller.onInit()),
                      },
                      {
                        "icon": "assets/icons8-report-32.png",
                        "label": "Transaction\nReport",
                        "onTap": () => Get.to(TransactionReportPage(),
                                binding: TransactionReportBinding())
                            ?.then((value) => controller.onInit()),
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
              Obx(() {
                return Card(
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
                        SizedBox(
                          height: 5,
                        ),
                        if (controller.predictionImage.value != null)
                          controller.predictionImage.value!.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: InteractiveViewer(
                                    child: Image.memory(
                                      controller.predictionImage.value!,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 150,
                                  alignment: AlignmentDirectional.center,
                                  child: Text("No internet connection"))
                        else
                          Container(
                              width: double.infinity,
                              height: 150,
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                  controller.canPredict.value ? "Loading.." :"Data range must be greater than 30 days"))
                      ],
                    ),
                  ),
                );
              }),
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
              Obx(() {
                return Container(
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
                                  FittedBox(
                                    child: Text(
                                      FunctionHelper.convertPriceWithComma(
                                          controller.sales.value),
                                      style: TextStyle(
                                          color: ColorTheme.COLOR_WHITE,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                  FittedBox(
                                    child: Text(
                                      FunctionHelper.convertPriceWithComma(
                                          controller.expenditure.value),
                                      style: TextStyle(
                                          color: ColorTheme.COLOR_WHITE,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
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
              Obx(() {
                return Container(
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
                                    "Total Transactions",
                                    style: TextStyle(
                                        color: ColorTheme.COLOR_GREY,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    controller.todayTransaction.value
                                        .toString(),
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
                                    controller.todaySoldProducts.value
                                        .toString(),
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
