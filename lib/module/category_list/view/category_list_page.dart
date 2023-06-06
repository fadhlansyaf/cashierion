import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/category_list_controller.dart';
import 'package:pos_app_skripsi/module/category_form/controller/category_form_binding.dart';
import 'package:pos_app_skripsi/module/category_detail/controller/category_detail_binding.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryListLogic>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
          actions: const [],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: ColorTheme.COLOR_WHITE,),
          onPressed: () async {
            await Get.to(CategoryFormPage(), binding: CategoryFormBinding())
                ?.then((value) => controller.onInit());
          },
        ),
        body: GetBuilder<CategoryListLogic>(
          assignId: true,
          builder: (logic) {
            if (!logic.isLoading.value) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: controller.categoryList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Get.to(
                                CategoryDetailPage(
                                    category: controller.categoryList[index],
                                    ),
                                binding: CategoryDetailBinding())
                            ?.then((value) => controller.onInit());
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
                              logic.categoryList[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              logic.categoryCount[index].toString() +
                                  ' item(s)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
