import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/category_detail/controller/category_detail_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import 'package:pos_app_skripsi/module/category_form/controller/category_form_binding.dart';

import '../controller/category_detail_controller.dart';
import '../widget/category_detail_widget.dart';
import '/utils/dialog.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({Key? key, required this.category})
      : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryDetailLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Detail"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                      () => CategoryFormPage(
                            category: category,
                            isEditing: true,
                          ),
                      binding: CategoryFormBinding())
                  ?.then((value) => controller.onInit());
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () async {
              Dialogs.deleteCategoryDialog(context, controller, category);
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CategoryDetailLogic>(builder: (logic) {
          if (!logic.isLoading.value) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CategoryDetailWidget(
                      title: 'Category Name', subtitle: category.name),
                  SizedBox(
                    height: 20,
                  ),
                  CategoryDetailWidget(
                      title: 'Description', subtitle: category.description),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
