import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

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
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByIndex(1, 1).setText("Title");
    sheet.getRangeByIndex(1, 2).setText("Links");
    
    final List<int> bytes = workbook.saveAsStream();
    FileStorage.writeCounter(bytes, "geeksforgeeks.xlsx");
    workbook.dispose();
  }
}

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
       // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }
  
    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }
  
  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }
  
static Future<File> writeCounter(List<int> bytes,String name) async {
  final path = await _localPath;
    // Create a file for the path of
      // device and file name with extension
    File file= File('$path/$name');
    print("Save file");
      
      // Write the data in the file you have created
    return file.writeAsBytes(bytes);
  }
}
