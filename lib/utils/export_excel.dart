import 'dart:io';
import 'package:cashierion/module/transaction_report/controller/transaction_report_controller.dart';
import 'package:cashierion/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';

class CreateExcel {
  static Future<void> createExcel(TransactionReportLogic controller) async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    int total = 0;
    if (controller.selectedFilter == 0) {
      sheet.getRangeByIndex(1, 1).setText("Order Report");
      sheet.getRangeByIndex(3, 1).setText("No");
      sheet.getRangeByIndex(3, 2).setText("Name");
      sheet.getRangeByIndex(3, 3).setText("Sold");
      sheet.getRangeByIndex(3, 4).setText("Price");
      sheet.getRangeByIndex(3, 5).setText("Sub total");
    } else {
      sheet.getRangeByIndex(1, 1).setText("Restock Report");
      sheet.getRangeByIndex(3, 1).setText("No");
      sheet.getRangeByIndex(3, 2).setText("Name");
      sheet.getRangeByIndex(3, 3).setText("Restock");
      sheet.getRangeByIndex(3, 4).setText("Price");
      sheet.getRangeByIndex(3, 5).setText("Sub total");
    }
    for (var i = 0; i < controller.reportList.length; i++) {
      sheet.getRangeByIndex(i + 4, 1).setText((i+1).toString());
      sheet.getRangeByIndex(i + 4, 2).setText(controller.reportList[i].name);
      sheet
          .getRangeByIndex(i + 4, 3)
          .setText(controller.reportList[i].totalQuantity.toString());
      sheet.getRangeByIndex(i + 4, 4).setText(
            FunctionHelper.convertPriceWithComma(
                controller.selectedFilter.value == 0
                    ? controller.reportList[i].productSellingPrice
                    : controller.reportList[i].productPrice),
          );
      sheet.getRangeByIndex(i + 4, 5).setText(
          FunctionHelper.convertPriceWithComma(
              controller.reportList[i].totalQuantity *
                  (controller.selectedFilter.value == 0
                      ? controller.reportList[i].productSellingPrice
                      : controller.reportList[i].productPrice)));
      total = controller.reportList[i].totalQuantity *
              (controller.selectedFilter.value == 0
                      ? controller.reportList[i].productSellingPrice
                      : controller.reportList[i].productPrice)
                  .toInt() +
          total;
    }
    sheet
        .getRangeByIndex(controller.reportList.length + 6, 4)
        .setText("Total:");
    sheet
        .getRangeByIndex(controller.reportList.length + 6, 5)
        .setText(FunctionHelper.convertPriceWithComma(total));

    final List<int> bytes =workbook.saveAsStream();
    workbook.dispose();

    final String path = '/storage/emulated/0/Download/';
    final String fileName = '$path/cashierion-report.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
    // FileStorage.writeCounter(bytes, "stock_report.xlsx");

    Get.snackbar('Success', 'stock_report.xlsx has been saved to downloads',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    // workbook.dispose();
    // String filePath = FileStorage.getFilePath("stock_report.xlsx");
    // OpenFile.open(filePath);
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

  static String getFilePath(String name) {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final path = _localPath;
    return '$path/$name';
  }

  static Future<File> writeCounter(List<int> bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension

    File file = File('$path/$name');
    print("Save file");

    // Write the data in the file you have created

    return file.writeAsBytes(bytes);
  }
}
