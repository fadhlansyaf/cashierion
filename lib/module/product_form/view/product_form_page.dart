import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../../../model/database/category.dart';
import '../../category_list/controller/category_list_dao.dart';
import '/utils/bottom_sheet.dart';
import '../widget/select_image_dialog.dart';
import '../widget/category_bottom_sheet.dart';
import '/widgets/custom_text_field.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductFormLogic>();
    final dao = Get.find<ProductFormDao>();
    final categoryController = Get.find<CategoryListLogic>();
    final categoryDao = Get.find<CategoryListDao>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductForm"),
        actions: [
          IconButton(
            onPressed: () async {
                  await dao.insertItem(ProductModel(
                      name: controller.textController[0].text,
                      price: double.parse(controller.textController[1].text),
                      sellingPrice:
                      double.parse(controller.textController[1].text),
                      stock: 0,
                      description: controller.textController[2].text,
                      image: controller.selectedImageBytes != null
                          ? base64Encode(controller.selectedImageBytes!)
                          : '',
                      productCategoryId: controller.selectedCategory.value?.id));
                  Get.back();
                },
            icon: const Icon(
              Icons.check,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return SelectImageDialog();
                      });
                },
                child: Obx(
                  () => controller.selectedImagePath.value == ''
                      ? Column(
                          children: [
                            Image.asset("assets/select-image.png"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Add image",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: Image.file(
                                  File(controller.selectedImagePath.value)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Change",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextFieldOld(
                controller: controller.textController[0],
                keyboardType: TextInputType.text,
                label: "Product Name",
                
              ),

              CustomTextFieldOld(
                controller: controller.textController[0],
                label: "Category",
                onTap: () {
                    BottomSheets.categoryModalBottomSheet(
                      context,
                      categoryController,
                      (category) {
                        controller.selectedCategory.value = category;
                      },
                    );
                }
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Obx(() {
              //   return GestureDetector(
              //     onTap: () {
              //       BottomSheets.categoryModalBottomSheet(
              //         context,
              //         categoryController,
              //         (category) {
              //           controller.selectedCategory.value = category;
              //         },
              //       );
              //     },
              //     child: Card(
              //       child: Container(
              //         padding: EdgeInsets.all(15),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Text(
              //                 "Category",
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.end,
              //                 children: [
              //                   Text(
              //                     controller.selectedCategory.value?.name ??
              //                         'No Category',
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 5,
              //                   ),
              //                   Icon(
              //                     Icons.edit,
              //                     size: 15,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // }),
              CustomTextFieldOld(
                controller: controller.textController[1],
                keyboardType: TextInputType.number,
                label: "Price",
                
              ),
              CustomTextFieldOld(
                controller: controller.textController[2],
                keyboardType: TextInputType.number,
                label: "Selling Price",
                
              ),
              CustomTextFieldOld(
                controller: controller.textController[3],
                keyboardType: TextInputType.number,
                label: "Stock",
                
              ),
              CustomTextFieldOld(
                controller: controller.textController[4],
                keyboardType: TextInputType.text,
                label: "Description",
                
              ),
            ],
          ),
        ),
      ),
    );
  }

// @override
// State<ProductFormPage> createState() => ProductFormController();
}
