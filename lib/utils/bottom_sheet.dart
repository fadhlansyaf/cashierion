import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../model/database/category.dart';
import '../model/database/database_model.dart';
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
                                        context, categoryFormController)
                                    .then((value) => controller
                                        .onInit()
                                        .then((value) => controller.setState));
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

  static Future<void> addCategoryModalBottomSheet(
    BuildContext context,
    CategoryFormLogic controller,
  ) async {
    await showModalBottomSheet<void>(
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
                          controller.insertOrUpdateCategory();
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
                  controller.insertOrUpdateCategory();
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
                  controller: controller.textController[1],
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

  static void paymentTypeModalBottomSheet(
      BuildContext context,
      HomeLogic controller,
      void Function(PaymentTypeModel paymentType) onSelected) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            //Masukin setState bottomsheet ini ke GetX
            controller.setStatePaymentType.value ??= setState;
            return Scaffold(
              appBar: SearchAppBar(
                title: Title(
                  color: ColorTheme.COLOR_WHITE,
                  child: Text("Search Payment Type"),
                ),
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            addPaymentTypeModalBottomSheet(context, controller)
                            .then((value) => controller
                                .initPayments()
                                .then((value) => controller.setStatePaymentType));
                          },
                          child: Text("Add Payment Type"),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.paymentType.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onSelected(controller.paymentType[index]);
                            Navigator.pop(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.paymentType[index].paymentName,
                                    style: TextStyle(
                                      fontSize: 16,
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
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> addPaymentTypeModalBottomSheet(
    BuildContext context,
    HomeLogic controller,
  ) async {
    await showModalBottomSheet<void>(
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
                        "Add Payment Type",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          controller.insertPaymentType();
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
                  await controller.insertPaymentType();
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
                  controller: controller.paymentTypeController,
                  keyboardType: TextInputType.text,
                  label: "Payment Type",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void paymentMethodModalBottomSheet(
      BuildContext context,
      HomeLogic controller,
      void Function(PaymentDetailModel paymentDetail) onSelected) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            //Masukin setState bottomsheet ini ke GetX
            controller.setStatePaymentDetail.value ??= setState;
            return Scaffold(
              appBar: SearchAppBar(
                title: Title(
                  color: ColorTheme.COLOR_WHITE,
                  child: Text("Search Payment Method"),
                ),
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            addPaymentMethodModalBottomSheet(context, controller)
                            .then((value) => controller
                                .initPayments()
                                .then((value) => controller.setStatePaymentDetail));
                          },
                          child: Text("Add Payment Method"),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.paymentDetail.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onSelected(controller.paymentDetail[index]);
                            Navigator.pop(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.paymentDetail[index].description,
                                    style: TextStyle(
                                      fontSize: 16,
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
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> addPaymentMethodModalBottomSheet(
    BuildContext context,
    HomeLogic controller,
  ) async {
    await showModalBottomSheet<void>(
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
                        "Add Payment Method",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          controller.insertPaymentDetail();
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
                  controller.insertPaymentDetail();
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
                // CustomTextFieldOld(
                //   controller: controller.textController[0],
                //   keyboardType: TextInputType.text,
                //   label: "Payment Method",
                // ),
                // CustomTextFieldOld(
                //   controller: controller.textController[1],
                //   keyboardType: TextInputType.text,
                //   label: "Description",
                // ),
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
