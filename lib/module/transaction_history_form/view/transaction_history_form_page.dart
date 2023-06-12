import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../../../theme/theme_constants.dart';
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
    controller.textController = List.generate(
        transactionDetail.length,
            (index) =>
        TextEditingController()
          ..text = transactionDetail[index].description);


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
            child: ListView.builder(
              itemCount: transactionDetail.length,
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
                          backgroundImage: products[index].image.isNotEmpty
                              ? MemoryImage(base64Decode(products[index].image))
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
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() {
                                  return CircleAvatar(
                                    backgroundColor:
                                        products[index].quantity.value.obs > 0
                                            ? ColorTheme.COLOR_CARD
                                            : ColorTheme.COLOR_PRIMARY,
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
                                  );
                                }),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Obx(() {
                                    return Text(
                                      products[index].quantity.value.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    );
                                  }),
                                ),
                                Obx(() {
                                  return CircleAvatar(
                                    backgroundColor:
                                        products[index].quantity.value > 0
                                            ? ColorTheme.COLOR_CARD
                                            : ColorTheme.COLOR_PRIMARY,
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
                                  );
                                }),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }else{
          return Container();
        }
      }),
    );
  }
}
