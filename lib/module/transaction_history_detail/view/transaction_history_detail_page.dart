import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/module/category_detail/controller/category_detail_dao.dart';
import 'package:cashierion/module/transaction_history_form/view/transaction_history_form_page.dart';
import 'package:cashierion/theme/theme_constants.dart';

import 'package:cashierion/module/transaction_history_form/controller/transaction_history_form_binding.dart';
import 'package:cashierion/utils/helper.dart';

import '../controller/transaction_history_detail_controller.dart';
import '../widget/transaction_history_detail_widget.dart';
import '/utils/dialog.dart';

class TransactionHistoryDetailPage extends StatelessWidget {
  const TransactionHistoryDetailPage({Key? key, required this.type})
      : super(key: key);
  final int type;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionHistoryDetailLogic>();

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.transaction.value.invoice),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                      () => TransactionHistoryFormPage(
                            transaction: controller.transaction.value,
                            transactionDetail: controller.transactionDetailList,
                            products: controller.productList,
                            type: type,
                          ),
                      binding: TransactionHistoryFormBinding())
                  ?.then((value) {
                    controller.isLoading.value = true;
                controller.onInit();
              });
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () async {
              Dialogs.deleteTransactionHistoryDialog(context, controller);
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (!controller.isLoading.value) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.transactionDetailList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: controller
                                        .productList[index].image.isNotEmpty
                                    ? MemoryImage(base64Decode(
                                        controller.productList[index].image))
                                    : null,
                                radius: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.productList[index].name,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${FunctionHelper.convertPriceWithComma(type == 0 ? controller.productList[index].sellingPrice : controller.productList[index].price)} x ${controller.transactionDetailList[index].quantity}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (controller.transactionDetailList[index]
                                        .description.isNotEmpty)
                                      SizedBox(
                                        child: Text(
                                          controller
                                              .transactionDetailList[index]
                                              .description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: ColorTheme.COLOR_WHITE,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    FunctionHelper.convertPriceWithComma(
                                        (type == 0
                                                ? controller.productList[index]
                                                    .sellingPrice
                                                : controller
                                                    .productList[index].price) *
                                            controller
                                                .transactionDetailList[index]
                                                .quantity),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TransactionHistoryDetailWidget(
                            title: "Total:",
                            subtitle: FunctionHelper.convertPriceWithComma(
                                controller.totalAmount.value)),
                        SizedBox(
                          height: 5,
                        ),
                        TransactionHistoryDetailWidget(
                            title: "Tax (${controller.tax.value}%):",
                            subtitle: FunctionHelper.convertPriceWithComma(
                                controller.taxTotal.value)),
                        SizedBox(
                          height: 5,
                        ),
                        TransactionHistoryDetailWidget(
                            title: "Total Price:",
                            subtitle: FunctionHelper.convertPriceWithComma(
                                controller.totalAmount.value +
                                    controller.taxTotal.value)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // GetBuilder<CategoryDetailLogic>(builder: (logic) {
            // if (!logic.isLoading.value) {
            //   return

            // } else {
            //   return const CircularProgressIndicator();
            // }
            // }),
          );
        } else {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                    color: ColorTheme.COLOR_PRIMARY,
                  ),
              ),
            );
        }
      }),
    );
  }
}
