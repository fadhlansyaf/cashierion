import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/module/product_form/controller/product_form_dao.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../../../model/database/category.dart';
import '../../category_list/controller/category_list_dao.dart';
import '/utils/bottom_sheet.dart';
import '../widget/select_image_dialog.dart';
import '../widget/category_bottom_sheet.dart';
import '/widgets/custom_text_field.dart';

///Jika isEditing true, product dan categories tidak boleh null
class ProductFormPage extends StatelessWidget {
  const ProductFormPage(
      {Key? key, this.isEditing = false, this.product, this.categories})
      : super(key: key);
  final bool isEditing;
  final ProductModel? product;
  final List<CategoryModel>? categories;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductFormLogic>();
    final categoryController = Get.find<CategoryListLogic>();
    final categoryFormController = Get.find<CategoryFormLogic>();
    if (isEditing && product != null && categories != null) {
      controller.textController[0].text = product!.name;
      controller.textController[1].text = product!.price.toString();
      controller.textController[2].text = product!.sellingPrice.toString();
      controller.textController[3].text = product!.stock.toString();
      controller.textController[4].text = product!.description;
      controller.textController[5].text = categories!
          .firstWhere((p0) => p0.id == product!.productCategoryId)
          .name;
      controller.selectedCategory.value =
          categories!.firstWhere((p0) => p0.id == product!.productCategoryId);
      controller.selectedImageBytes =
          product!.image.isNotEmpty ? base64Decode(product!.image) : null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit ${product!.name}" : "Add Product"),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                controller.insertOrEditProduct(product);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Processing Data')),
                // );
              }
            },
            icon: const Icon(
              Icons.check,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    child: controller.selectedImagePath.value == '' &&
                            controller.selectedImageBytes == null
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
                                height: (MediaQuery.of(context).size.width) / 2,
                                child: controller.selectedImageBytes != null
                                    ? Image.memory(
                                        controller.selectedImageBytes!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(
                                            controller.selectedImagePath.value),
                                        fit: BoxFit.cover,
                                      ),
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
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextFieldOld(
                    controller: controller.textController[0],
                    keyboardType: TextInputType.text,
                    validation: true,
                    label: "Product Name *",
                  ),
                  CustomTextFieldOld(
                    controller: controller.textController[5],
                    label: "Category *",
                    validation: true,
                    onTap: () {
                      BottomSheets.categoryModalBottomSheet(
                        context,
                        categoryController,
                        categoryFormController,
                        (category) {
                          controller.selectedCategory.value = category;
                          controller.textController[5].text = category.name;
                        },
                      );
                    },
                  ),
                  CustomTextFieldOld(
                    controller: controller.textController[1],
                    keyboardType: TextInputType.number,
                    validation: true,
                    label: "Price *",
                  ),
                  CustomTextFieldOld(
                    controller: controller.textController[2],
                    keyboardType: TextInputType.number,
                    validation: true,
                    label: "Selling Price *",
                  ),
                  CustomTextFieldOld(
                    controller: controller.textController[3],
                    keyboardType: TextInputType.number,
                    validation: true,
                    label: "Stock *",
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
      }),
    );
  }

// @override
// State<ProductFormPage> createState() => ProductFormController();
}
