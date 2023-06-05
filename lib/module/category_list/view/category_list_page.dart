import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/category_list_controller.dart';
import 'package:pos_app_skripsi/module/category_form/controller/category_form_binding.dart';
import 'package:pos_app_skripsi/module/category_detail/controller/category_detail_binding.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<CategoryListLogic>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
          actions: const [],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Get.to(CategoryFormPage(), binding: CategoryFormBinding());
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: 2,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () 
                  async {
                  await Get.to(CategoryDetailPage(
                    // category: controller.categories[index],
                    ),
                      binding: CategoryDetailBinding())?.then((value) => controller.onInit());
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: ColorTheme.COLOR_CARD,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                      ),
                      Spacer(),
                      Text(
                        "2 Product(s)",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
