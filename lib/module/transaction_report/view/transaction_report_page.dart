import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/utils/helper.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '/utils/export_excel.dart';

import 'package:cashierion/core.dart';
import 'package:cashierion/module/transaction_history_detail/view/transaction_history_detail_page.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../controller/transaction_report_controller.dart';
import '../widget/date_picker.dart';
import '/utils/bottom_sheet.dart';
import 'package:cashierion/module/transaction_report/view/transaction_report_page.dart';
import 'package:cashierion/module/transaction_report/controller/transaction_report_binding.dart';

class TransactionReportPage extends StatelessWidget {
  const TransactionReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionReportLogic>();
    List<ReportProductModel> duplicate = [];
    duplicate.addAll(controller.reportList);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transaction Report"),
          actions: const [],
        ),
        body: GetBuilder<TransactionReportLogic>(
          assignId: true,
          builder: (logic) {
            if (!logic.isLoading.value) {
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      // child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DatePicker(
                                  startDate: controller.startDate,
                                  endDate: controller.endDate,
                                  controller: controller,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    BottomSheets.filterModalBottomSheet(
                                      context,
                                      controller,
                                      (selectedFilter) {
                                        controller.selectedFilter.value =
                                            selectedFilter;
                                        controller.onInit();
                                      },
                                    );
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Report",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(Icons.keyboard_arrow_down),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            controller.filter[controller
                                                .selectedFilter.value],
                                            style: TextStyle(
                                              fontSize: 16,
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

                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  List<ReportProductModel> searched = [];
                                  for (var e in controller.reportList) {
                                    if (e.name
                                        .toLowerCase()
                                        .contains(value.toLowerCase())) {
                                      searched.add(e);
                                    } else if (e.name != null) {
                                      if (e.name!
                                          .toLowerCase()
                                          .contains(value.toLowerCase())) {
                                        searched.add(e);
                                      }
                                    }
                                  }
                                  controller.reportList.clear();
                                  controller.reportList.addAll(searched);
                                } else {
                                  controller.reportList.clear();
                                  controller.reportList.addAll(duplicate);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reportList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.reportList[index].name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              FunctionHelper
                                                  .convertPriceWithComma(
                                                      controller.selectedFilter
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .reportList[index]
                                                              .productSellingPrice
                                                          : controller
                                                              .reportList[index]
                                                              .productPrice),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${controller.reportList[index].totalQuantity} item(s) ${controller.selectedFilter.value == 0 ? 'sold' : 'restocked'}",
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          FunctionHelper.convertPriceWithComma(
                                              controller.reportList[index]
                                                      .totalQuantity *
                                                  (controller.selectedFilter
                                                              .value ==
                                                          0
                                                      ? controller
                                                          .reportList[index]
                                                          .productSellingPrice
                                                      : controller
                                                          .reportList[index]
                                                          .productPrice)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          CreateExcel.createExcel();
                        },
                        child: Row(
                            children: [
                              Icon(Icons.table_chart_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Export to Excel"),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
