import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../../../theme/theme_constants.dart';
import '../../../utils/dialog.dart';
import '../../../utils/helper.dart';
import '../controller/transaction_history_form_controller.dart';
import '/widgets/custom_text_field.dart';

class TransactionHistoryFormPage extends StatelessWidget {
  const TransactionHistoryFormPage({Key? key,
    this.isEditing = true,
    required this.transactionDetail,
    required this.transaction,
    required this.products})
      : super(key: key);
  final bool isEditing;
  final List<TransactionDetailModel> transactionDetail;
  final List<ProductModel> products;
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionHistoryFormLogic>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${transaction.invoice}"),
        actions: [
          IconButton(
            onPressed: () {
              controller.editTransaction(
                  transactionDetail, products, transaction);
            },
            icon: const Icon(
              Icons.check,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if(!controller.isEdited.value) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: transactionDetail.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Ink(
                            child: InkWell(
                              onLongPress: () {
                                Dialogs.productQuantityDialog(context, products[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage: products[index].image.isNotEmpty
                                          ? MemoryImage(
                                          base64Decode(products[index].image))
                                          : null,
                                      radius: 20,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index].name,
                                          // style: TextStyle(
                                          //   fontSize: 16,
                                          //   fontWeight: FontWeight.bold,
                                          // ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          FunctionHelper.convertPriceWithComma(
                                              products[index].price),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            products[index].description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: ColorTheme.COLOR_WHITE,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          child: Obx(() {
                                            return Text(
                                              '${FunctionHelper.convertPriceWithComma(products[index].quantity * products[index].price)}',
                                              // "Rp " + (products[index].quantity*products[index].price).toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: ColorTheme.COLOR_PRIMARY,
                                              radius: 15.0,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (products[index].quantity.value >
                                                        0) {
                                                      products[index].quantity.value--;
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 9.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Obx(() {
                                                return Text(
                                                  products[index]
                                                      .quantity
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                );
                                              }),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: ColorTheme.COLOR_PRIMARY,
                                              radius: 15.0,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (products[index].quantity.value <
                                                        products[index].stock +
                                                            transactionDetail[index]
                                                                .quantity &&
                                                        transaction.invoice
                                                            .startsWith('CO')) {
                                                      products[index].quantity.value++;
                                                    } else if (!transaction.invoice
                                                        .startsWith('CO')) {
                                                      products[index].quantity.value++;
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 9.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("Total"),
                            ),
                            // Text(FunctionHelper.convertPriceWithComma(
                            //     transactionDetail.totalAmount.value)),
                            Text("Rp 10.000"),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Tax 10%"),
                            ),
                            // Text(FunctionHelper.convertPriceWithComma(
                            //     controller.tax.value)),
                            Text("Rp 1.000"),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Total Price")),
                            // Text(FunctionHelper.convertPriceWithComma(
                            //     controller.totalAmount.value +
                            //         controller.tax.value)),
                            Text("Rp 11.000"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Container();
        }
      }),
    );
  }
}
