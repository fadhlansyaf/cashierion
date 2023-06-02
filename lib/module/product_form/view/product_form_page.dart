import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/product_form_controller.dart';

import '/utils/bottom_sheeet.dart';
import '../widget/select_image_dialog.dart';
import '../widget/category_bottom_sheet.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<ProductFormLogic>();
    final dao = Get.find<ProductFormDao>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductForm"),
        actions: [
          IconButton(
            onPressed: () {},
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
              TextFormField(
                controller: controller.textController[0],
                cursorColor: ColorTheme.COLOR_WHITE,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () => {
                  BottomSheets.categoryModalBottomSheet(context)
                  // showModalBottomSheet<void>(
                  //   isScrollControlled: true,
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return CategoryBottomSheet(
                  //       title: Title(
                  //           color: ColorTheme.COLOR_WHITE,
                  //           child: Text("Search Category")),
                  //     );
                  //   },
                  // )
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Category",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.textController[1],
                cursorColor: ColorTheme.COLOR_WHITE,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.textController[1],
                cursorColor: ColorTheme.COLOR_WHITE,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Selling Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.textController[1],
                cursorColor: ColorTheme.COLOR_WHITE,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Stock',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.textController[2],
                cursorColor: ColorTheme.COLOR_WHITE,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                onPressed: () async {
                  await dao.insertItem(Products(
                      name: controller.textController[0].text,
                      price: double.parse(controller.textController[1].text),
                      sellingPrice:
                          double.parse(controller.textController[1].text),
                      stock: 0,
                      description: controller.textController[2].text, image: ''));
                  Get.back();
                },
              ),
              SizedBox(
                height: 40,
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
