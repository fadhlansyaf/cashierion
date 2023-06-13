import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';
import 'transaction_view.dart';
import 'transaction_detail.dart';

class TransactionNavView extends StatelessWidget {
  static PageController pageController = PageController();
  final controller = Get.find<HomeLogic>();
  final _pages = [
    TransactionView(
      pageController: pageController,
    ),
    TransactionDetailView(
      pageController: pageController,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return IconButton(
                        onPressed: () {
                          pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: controller.pageIndex.value == 0
                              ? ColorTheme.COLOR_WHITE.withOpacity(0)
                              : ColorTheme.COLOR_WHITE,
                        ),
                      );
                    }),
                    Text(
                      "Transaction",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    controller.pageIndex.value == 0
                        ? ElevatedButton(
                            onPressed: () {
                              controller.clearAllItems();
                            },
                            child: Text("Clear All"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(ColorTheme.COLOR_ACTIVE),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      body: PageView(
        onPageChanged: (value) {
          controller.pageIndex.value = value;
        },
        controller: pageController,
        children: _pages,
      ),
    );
  }
}
