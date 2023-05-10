import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:open_file/open_file.dart';
import '../controller/stock_report_controller.dart';

class StockReportView extends StatelessWidget {
  const StockReportView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<StockReportLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("StockReport"),
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
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Hello World');
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}
