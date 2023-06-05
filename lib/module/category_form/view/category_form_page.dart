import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../controller/category_form_controller.dart';
import '/widgets/custom_text_field.dart';

class CategoryFormPage extends StatelessWidget {
  const CategoryFormPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<CategoryFormLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Form"),
        actions: [
          IconButton(
            onPressed: () {
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
              CustomTextFieldOld(
                controller: controller.textController[0],
                keyboardType: TextInputType.text,
                label: "Category Name",
              ),
              CustomTextFieldOld(
                controller: controller.textController[2],
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
