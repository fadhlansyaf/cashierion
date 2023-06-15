import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';

import '../controller/category_form_controller.dart';
import '/widgets/custom_text_field.dart';

class CategoryFormPage extends StatelessWidget {
  const CategoryFormPage({Key? key, this.isEditing = false, this.category})
      : super(key: key);
  final bool isEditing;
  final CategoryModel? category;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryFormLogic>();
    if (isEditing && category != null) {
      controller.textController[0].text = category!.name;
      controller.textController[1].text = category!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit ${category!.name}" : "Add Category"),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.insertOrUpdateCategory(category);
              }
            },
            icon: const Icon(
              Icons.check,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomTextFieldOld(
                  controller: controller.textController[0],
                  keyboardType: TextInputType.text,
                  validation: true,
                  label: "Category Name *",
                ),
                CustomTextFieldOld(
                  controller: controller.textController[1],
                  keyboardType: TextInputType.text,
                  label: "Description",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
