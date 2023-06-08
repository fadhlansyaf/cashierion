import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../controller/transaction_history_form_controller.dart';
import '/widgets/custom_text_field.dart';

class TransactionHistoryFormPage extends StatelessWidget {
  const TransactionHistoryFormPage({
    Key? key,
    this.isEditing = false,
    //  this.category
  }) : super(key: key);
  final bool isEditing;
  // final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionHistoryFormLogic>();
    // if(isEditing && category != null){
    //   controller.textController[0].text = category!.name;
    //   controller.textController[1].text = category!.description;
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History Form"),
        actions: [
          IconButton(
            onPressed: () {
              // controller.insertOrUpdateCategory(category);
            },
            icon: const Icon(
              Icons.check,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            var item = "item";
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: null,
                      radius: 20,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // controller.products[index].name,
                          "Name",
                          // style: TextStyle(
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          // controller.products[index].description,
                          "Rp 10.000",
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
                        // Text("data"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Obx(() {
                            //   return
                            CircleAvatar(
                              // backgroundColor:
                              //     products[secondIndex]
                              //                 .quantity
                              //                 .value
                              //                 .obs >
                              //             0
                              //         ? ColorTheme
                              //             .COLOR_CARD
                              //         : ColorTheme
                              //             .COLOR_PRIMARY,
                              radius: 15.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    // if (products[
                                    //             secondIndex]
                                    //         .quantity
                                    //         .value >
                                    //     0) {
                                    //   products[
                                    //           secondIndex]
                                    //       .quantity
                                    //       .value--;
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                            // }),
                            Padding(
                                padding: EdgeInsets.all(8.0), child: Text("1")
                                // Obx(() {
                                //   return Text(
                                //     products[secondIndex]
                                //         .quantity
                                //         .value
                                //         .toString(),
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //     ),
                                //   );
                                // }),
                                ),
                            // Obx(() {
                            //   return
                            CircleAvatar(
                              // backgroundColor:
                              //     products[secondIndex]
                              //                 .quantity
                              //                 .value >
                              //             0
                              //         ? ColorTheme
                              //             .COLOR_CARD
                              //         : ColorTheme
                              //             .COLOR_PRIMARY,
                              radius: 15.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    // if (products[secondIndex]
                                    //             .quantity
                                    //             .value <
                                    //         products[
                                    //                 secondIndex]
                                    //             .stock &&
                                    //     controller.isOrder
                                    //         .value) {
                                    //   products[
                                    //           secondIndex]
                                    //       .quantity
                                    //       .value++;
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                            // }),
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
      ),
    );
  }
}
