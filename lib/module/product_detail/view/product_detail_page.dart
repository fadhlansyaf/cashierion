import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_detail/controller/product_detail_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import 'package:pos_app_skripsi/module/product_form/controller/product_form_binding.dart';

import '../controller/product_detail_controller.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailLogic>();
    final dao = Get.find<ProductDetailDao>();

    // set up the buttons

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductDetail"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(() => ProductFormPage(), binding: ProductFormBinding())
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
            },
            icon: const Icon(
              Icons.delete,
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
              Obx(
                () => controller.selectedImagePath.value == ''
                    ? Column(
                        children: [
                          Image.asset("assets/select-image.png"),
                          SizedBox(
                            height: 20,
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
                        ],
                      ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.COLOR_WHITE,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name",
                      style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Product Name",
                      style: TextStyle(
                          color: ColorTheme.COLOR_WHITE, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.COLOR_WHITE,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                          color: ColorTheme.COLOR_WHITE, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.COLOR_WHITE,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Price",
                      style: TextStyle(
                          color: ColorTheme.COLOR_WHITE, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.COLOR_WHITE,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selling Price",
                      style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Selling Price",
                      style: TextStyle(
                          color: ColorTheme.COLOR_WHITE, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.COLOR_WHITE,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: ColorTheme.COLOR_WHITE, fontSize: 18),
                    ),
                  ],
                ),
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
