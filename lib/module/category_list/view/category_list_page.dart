import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../controller/category_list_controller.dart';
import 'package:cashierion/module/category_form/controller/category_form_binding.dart';
import 'package:cashierion/module/category_detail/controller/category_detail_binding.dart';

import '/widgets/search_appbar.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryListLogic>();
    List<CategoryModel> duplicate = [];
    duplicate.addAll(controller.categoryList);

    return Scaffold(
        appBar: SearchAppBar(
          title: Title(
            color: ColorTheme.COLOR_WHITE,
            child: Text("Category"),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              List<CategoryModel> searched = [];
              for (var e in controller.categoryList) {
                if (e.name.toLowerCase().contains(value.toLowerCase())) {
                  searched.add(e);
                } else if (e.name != null) {
                  if (e.name!.toLowerCase().contains(value.toLowerCase())) {
                    searched.add(e);
                  }
                }
              }
              controller.categoryList.clear();
              controller.categoryList.addAll(searched);
            } else {
              controller.categoryList.clear();
              controller.categoryList.addAll(duplicate);
            }
          },
          height: MediaQuery.of(context).size.height * 0.14,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: ColorTheme.COLOR_WHITE,
          ),
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
                child: Obx(() {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
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
                  );
                }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
