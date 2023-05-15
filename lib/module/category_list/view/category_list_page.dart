import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';

import '../controller/category_list_controller.dart';
import 'package:pos_app_skripsi/module/category_form/controller/category_form_binding.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<CategoryListLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductList"),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(CategoryFormPage(),binding: CategoryFormBinding());
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  var item = "item";
                  return Card(
                    child: ListTile(
                      title: const Text("Jessica Doe"),
                      trailing: IconButton(
                        onPressed: () async {
                          // await OldGet.to(const ProductFormPage(
                          // ));
                          await Get.to(CategoryFormPage(),binding: CategoryFormBinding());
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 24.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
