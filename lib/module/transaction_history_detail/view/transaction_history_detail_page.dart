import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/category_detail/controller/category_detail_dao.dart';
import 'package:pos_app_skripsi/module/transaction_history_form/view/transaction_history_form_page.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import 'package:pos_app_skripsi/module/transaction_history_form/controller/transaction_history_form_binding.dart';

import '../controller/transaction_history_detail_controller.dart';
import '../widget/transaction_history_detail_widget.dart';

class TransactionHistoryDetailPage extends StatelessWidget {
  const TransactionHistoryDetailPage({
    Key? key,
    // required this.category
  }) : super(key: key);
  // final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionHistoryDetailLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Code"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                      () => TransactionHistoryFormPage(
                          // category: category,
                          isEditing: true,),
                      binding: TransactionHistoryFormBinding())
                  ?.then((value) => controller.onInit());
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                      'This action will permanently delete this data'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                      ),
                    ),
                  ],
                ),
              );
              if (result == true) {
                // controller.deleteCategory(category);
              }
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
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
                                "Rp 10.000 x 2",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
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
                        title: "Total:", subtitle: "Rp 10.000"),
                    SizedBox(
                      height: 5,
                    ),
                    TransactionHistoryDetailWidget(
                        title: "Tax (10%):", subtitle: "Rp 4.000"),
                    SizedBox(
                      height: 5,
                    ),
                    TransactionHistoryDetailWidget(
                        title: "Total Price:", subtitle: "Rp 14.000"),
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
      ),
    );
  }
}
