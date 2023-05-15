import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../controller/category_form_controller.dart';

class CategoryFormPage extends StatelessWidget {
  const CategoryFormPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<CategoryFormLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("CategoryForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: controller.textController[0],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Category Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  // await dao.insertItem(ProductsModel(
                  //     name: controller.textController[0].text,
                  //     price: double.parse(controller.textController[1].text),
                  //     sellingPrice: double.parse(controller.textController[1].text),
                  //     stock: 0,
                  //     description: controller.textController[2].text));
                  // Get.back();
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
