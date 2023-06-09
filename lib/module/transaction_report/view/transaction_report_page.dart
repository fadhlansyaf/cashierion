import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '/utils/export_excel.dart';

import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/transaction_history_detail/view/transaction_history_detail_page.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/transaction_report_controller.dart';
import '../widget/date_picker.dart';
import '/utils/bottom_sheet.dart';
import 'package:pos_app_skripsi/module/transaction_report/view/transaction_report_page.dart';
import 'package:pos_app_skripsi/module/transaction_report/controller/transaction_report_binding.dart';

class TransactionReportPage extends StatelessWidget {
  const TransactionReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionReportLogic>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Transaction Report"),
          actions: const [],
        ),
        body: GetBuilder<TransactionReportLogic>(
          assignId: true,
          builder: (logic) {
            if (logic.isLoading.value) {
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
                                child: DatePicker(),
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
                                            "Sales",
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
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 20,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              var item = "item";
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
                                            "Produk 1",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Rp 6.000",
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "5 item(s) sold",
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rp 30.000",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
