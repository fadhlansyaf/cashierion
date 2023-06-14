import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';

import '../controller/store_profile_form_controller.dart';
import '/widgets/custom_text_field.dart';

class StoreProfileFormPage extends StatelessWidget {
  const StoreProfileFormPage({
    Key? key,
    this.isEditing = false,
  }) : super(key: key);
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreProfileFormLogic>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Store Profile"),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.saveStoreProfile();
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
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFieldOld(
                  controller: controller.textController[0],
                  keyboardType: TextInputType.text,
                  validation: true,
                  label: "Store Name",
                ),
                CustomTextFieldOld(
                  controller: controller.textController[1],
                  keyboardType: TextInputType.number,
                  label: "Phone Number",
                ),
                CustomTextFieldOld(
                  controller: controller.textController[2],
                  keyboardType: TextInputType.text,
                  label: "Address",
                ),
                CustomTextFieldOld(
                  controller: controller.textController[3],
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
