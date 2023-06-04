import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../model/database/category.dart';
import '../module/product_form/widget/search_appbar.dart';
import 'no_overscroll.dart';
import '/widgets/custom_text_field.dart';

class BottomSheets {
  static void categoryModalBottomSheet(
      BuildContext context,
      CategoryListLogic controller,
      CategoryFormLogic categoryFormController,
      void Function(CategoryModel category) onSelected) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            //Masukin setState bottomsheet ini ke GetX
            controller.setState.value ??= setState;
            return Scaffold(
              appBar: SearchAppBar(
                title: Title(
                  color: ColorTheme.COLOR_WHITE,
                  child: Text("Search Category"),
                ),
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              body: Obx(
                () {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                addCategoryModalBottomSheet(
                                    context, categoryFormController);
                              },
                              child: Text("Add Category"),
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.categoryList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                onSelected(controller.categoryList[index]);
                                Navigator.pop(context);
                              },
                              //TODO: Ganti ListTile => Done
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.categoryList[index].name,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        controller.selectedIndex.value
                                            .toString(),
                                        style: TextStyle(
                                          color: ColorTheme.COLOR_GREY,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  static void addCategoryModalBottomSheet(
    BuildContext context,
    // CategoryListLogic controller,
    CategoryFormLogic controller,
    // ntar ganti aja
    // void Function(CategoryModel category) onSelected
  ) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        "Add Category",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: 40,
            actions: [
              IconButton(
                onPressed: () async {
                  Get.back();
                },
                icon: const Icon(
                  Icons.check,
                  size: 24.0,
                ),
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(10),
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
        );
      },
    );
  }

  static Future<dynamic> spinner({
    required BuildContext context,
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(SpinnerItem selectedItem) onSelected,
  }) async {
    List<SpinnerItem> duplicate = [];
    duplicate.addAll(spinnerItems);

    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Material(
                color: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Scaffold(
                      backgroundColor: Theme.of(context).primaryColor,
                      appBar: SearchAppBar(
                        title: Text(title),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            List<SpinnerItem> searched = [];
                            for (var e in spinnerItems) {
                              if (e.description
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                                searched.add(e);
                              } else if (e.subDescription != null) {
                                if (e.subDescription!
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  searched.add(e);
                                }
                              }
                            }
                            spinnerItems.clear();
                            spinnerItems.addAll(searched);
                          } else {
                            spinnerItems.clear();
                            spinnerItems.addAll(duplicate);
                          }
                          setState(() {});
                        },
                        height: MediaQuery.of(context).size.height * 0.125,
                      ),
                      body: Container(
                        height: MediaQuery.of(context).size.height * 0.875,
                        child: ScrollConfiguration(
                          behavior: NoOverscrollBehavior(),
                          child: ListView.builder(
                            itemCount: spinnerItems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  onSelected(spinnerItems[index]);
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Text(
                                          spinnerItems[index]
                                              .description[0]
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                spinnerItems[index].description,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              if (spinnerItems[index]
                                                      .subDescription !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                      spinnerItems[index]
                                                          .subDescription!),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                ));
          });
        });
  }

  @override
  static Widget CategoryBottomSheet(context) {
    // final controller = Get.find<ProductFormLogic>();

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Search Category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(100),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
      ),
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          var item = "item";
          return Card(
            child: ListTile(
              title: const Text("Jessica Doe"),
            ),
          );
        },
      ),
    );
  }

// @override
// Size get preferredSize => Size.fromHeight(getHeight());
}

class SpinnerItem {
  final dynamic identity;
  final String description;
  final dynamic tag;
  final String? subDescription;

  SpinnerItem(
      {required this.identity,
      required this.description,
      this.tag,
      this.subDescription});
}
