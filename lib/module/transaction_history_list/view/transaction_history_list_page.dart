import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/view/transaction_history_detail_page.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../../../utils/helper.dart';
import '../controller/transaction_history_list_controller.dart';
import '../widget/date_picker.dart';
import '/utils/bottom_sheet.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/view/transaction_history_detail_page.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/controller/transaction_history_detail_binding.dart';

class TransactionHistoryListPage extends StatelessWidget {
  const TransactionHistoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionHistoryListLogic>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Transaction History"),
          actions: const [],
        ),
        body: GetBuilder<TransactionHistoryListLogic>(
          assignId: true,
          builder: (logic) {
            if (logic.isLoading.value) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(10),
                // child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DatePicker(startDate: controller.startDate,
                            endDate: controller.endDate,
                            controller: controller,),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              BottomSheets.filterModalBottomSheet(
                                  context, (category) {});
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                constraints: BoxConstraints(minHeight: 70),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Filter",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.keyboard_arrow_down),
                                      ],
                                    ),
                                    Text("Sales", style: TextStyle(
                                      fontSize: 16,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        // controller: controller,
                        style: TextStyle(
                          color: ColorTheme.COLOR_WHITE,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: ColorTheme.COLOR_WHITE,
                              size: 20,
                            ),
                            focusColor: ColorTheme.COLOR_WHITE,
                            hintStyle: TextStyle(
                              color: ColorTheme.COLOR_WHITE,
                            ),
                            hintText: 'search',
                            fillColor: ColorTheme.COLOR_CARD,
                            filled: true),
                        onEditingComplete: () {
                          // if (onEditingComplete != null) {
                          //   onEditingComplete!(controller!.text);
                          // }
                        },
                        // onChanged: onChanged,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 6 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: controller.transactionList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () async {
                              await Get.to(
                                  TransactionHistoryDetailPage(
                                    // category: controller.categoryList[index],
                                  ),
                                  binding: TransactionHistoryDetailBinding())
                                  ?.then((value) => controller.onInit());
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: ColorTheme.COLOR_CARD,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.transactionList[index].invoice,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.transactionList[index].dates,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${controller
                                        .transactionCount[index]} items",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    FunctionHelper.convertPriceWithComma(
                                        controller.transactionList[index]
                                            .sales),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                  // ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
