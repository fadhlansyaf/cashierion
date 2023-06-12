import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';

import '../controller/store_profile_form_controller.dart';
import '/widgets/custom_text_field.dart';

class StoreProfileFormPage extends StatelessWidget {
  const StoreProfileFormPage({Key? key, this.isEditing = false, 
  this.category
  }) : super(key: key);
  final bool isEditing;
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreProfileFormLogic>();
    if(isEditing && category != null){
      controller.textController[0].text = category!.name;
      controller.textController[1].text = category!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Profile Form"),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomTextFieldOld(
                controller: controller.textController[0],
                keyboardType: TextInputType.text,
                label: "Store Name",
              ),
              CustomTextFieldOld(
                controller: controller.textController[1],
                keyboardType: TextInputType.text,
                label: "Phone Number",
              ),
              CustomTextFieldOld(
                controller: controller.textController[1],
                keyboardType: TextInputType.text,
                label: "Phone Address",
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
    );
  }
}
