import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cashierion/core.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cashierion/utils/export_excel.dart';
// import 'package:cashierion/main.dart';

import '../controller/sales_report_controller.dart';

class SalesReportPage extends StatelessWidget {
  const SalesReportPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<SalesReportLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SalesReport"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Stock')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Item 1')),
                      DataCell(Text('2')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Item 2')),
                      DataCell(Text('3')),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: createExcel,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createExcel() async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByIndex(1, 1).setText("Title");
    sheet.getRangeByIndex(1, 2).setText("Links");

    final List<int> bytes = workbook.saveAsStream();
    FileStorage.writeCounter(bytes, "sales_report.xlsx");
    Get.snackbar('Success', 'sales_report.xlsx has been saved',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    workbook.dispose();
  }
}


