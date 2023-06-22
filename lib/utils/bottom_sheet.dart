import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/theme/theme_constants.dart';
import 'package:cashierion/utils/dialog.dart';

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
    List<CategoryModel> duplicate = [];
    duplicate.addAll(controller.categoryList);
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
                onChanged: (value) {
                  List<CategoryModel> searched = [];
                  if (value.isNotEmpty) {
                    for (var e in controller.categoryList) {
                      if (e.name.toLowerCase().contains(value.toLowerCase())) {
                        searched.add(e);
                      } else if (e.name != null) {
                        if (e.name!
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
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
                  controller.setState.value;
                },
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
      bool isEdit,
      void Function(PaymentTypeModel paymentType) onSelected) {
    List<PaymentTypeModel> duplicate = [];
    duplicate.addAll(controller.paymentType);
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
                  child: Text(
                      !isEdit ? "Choose Payment Type" : "Edit Payment Type"),
                ),
                onChanged: (value) {
                  List<PaymentTypeModel> searched = [];
                  if (value.isNotEmpty) {
                    for (var e in controller.paymentType) {
                      if (e.paymentName
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        searched.add(e);
                      } else if (e.paymentName != null) {
                        if (e.paymentName!
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          searched.add(e);
                        }
                      }
                    }
                    controller.paymentType.clear();
                    controller.paymentType.addAll(searched);
                  } else {
                    controller.paymentType.clear();
                    controller.paymentType.addAll(duplicate);
                  }
                  controller.setStatePaymentType.value;
                },
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              body: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              addPaymentTypeModalBottomSheet(
                                      context, controller, false)
                                  .then((value) => controller
                                      .initPayments()
                                      .then((value) =>
                                          controller.setStatePaymentType));
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
                              if (!isEdit) {
                                onSelected(controller.paymentType[index]);
                                Navigator.pop(context);
                              } else {
                                addPaymentTypeModalBottomSheet(
                                        context,
                                        controller,
                                        isEdit,
                                        controller.paymentType[index])
                                    .then(
                                  (value) => controller.initPayments().then(
                                      (value) =>
                                          controller.setStatePaymentType),
                                );
                              }
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
                );
              }),
            );
          },
        );
      },
    );
  }

  static Future<void> addPaymentTypeModalBottomSheet(
    BuildContext context,
    HomeLogic controller,
    bool isEdit,

    ///Jika isEdit true maka tidak boleh null
    [
    PaymentTypeModel? paymentType,
  ]) async {
    if (paymentType != null && isEdit) {
      controller.paymentTypeController.text = paymentType.paymentName;
    }
    final _formKey = GlobalKey<FormState>();
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
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
                            !isEdit ? "Add Payment Type" : "Edit Payment Type",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          isEdit
                              ? IconButton(
                                  onPressed: () async {
                                    Dialogs.deletePaymentTypeDialog(
                                        context, controller, paymentType!);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 24.0,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.delete,
                                    size: 24.0,
                                    color:
                                        ColorTheme.COLOR_WHITE.withOpacity(0),
                                  ),
                                ),
                          IconButton(
                            onPressed: () async {
                              if (!isEdit) {
                                if (_formKey.currentState!.validate()) {
                                  await controller.insertPaymentType();
                                }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  await controller.editPaymentType(
                                      PaymentTypeModel(
                                          id: paymentType!.id,
                                          paymentName: controller
                                              .paymentTypeController.text));
                                }
                              }
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
                      if (!isEdit) {
                        if (_formKey.currentState!.validate()) {
                          await controller.insertPaymentType();
                        }
                      } else {
                        if (_formKey.currentState!.validate()) {
                          await controller.editPaymentType(PaymentTypeModel(
                              id: paymentType!.id,
                              paymentName:
                                  controller.paymentTypeController.text));
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              body: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomTextFieldOld(
                        controller: controller.paymentTypeController,
                        keyboardType: TextInputType.text,
                        validation: true,
                        label: "Payment Type *",
                      ),
                    ],
                  ),
                ),
              ));
        });
      },
    );
  }

  static void paymentMethodModalBottomSheet(
      BuildContext context,
      HomeLogic controller,
      bool isEdit,
      void Function(PaymentDetailModel paymentDetail) onSelected) {
    List<PaymentDetailModel> duplicate = [];
    duplicate.addAll(controller.allPaymentDetail);
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
                  child: Text(!isEdit
                      ? "Choose Payment Method"
                      : "Edit Payment Method"),
                ),
                onChanged: (value) {
                  List<PaymentDetailModel> searched = [];
                  if (value.isNotEmpty) {
                    for (var e in controller.allPaymentDetail) {
                      if (e.description
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        searched.add(e);
                      } else if (e.description != null) {
                        if (e.description!
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          searched.add(e);
                        }
                      }
                    }
                    controller.allPaymentDetail.clear();
                    controller.allPaymentDetail.addAll(searched);
                  } else {
                    controller.allPaymentDetail.clear();
                    controller.allPaymentDetail.addAll(duplicate);
                  }
                  controller.setStatePaymentDetail.value;
                },
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              body: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              addPaymentMethodModalBottomSheet(
                                      context, controller, false)
                                  .then((value) => controller
                                      .initPayments()
                                      .then((value) =>
                                          controller.setStatePaymentDetail));
                            },
                            child: Text("Add Payment Method"),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: isEdit
                            ? controller.allPaymentDetail.length
                            : controller.specificPaymentDetail.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (!isEdit) {
                                onSelected(
                                    controller.specificPaymentDetail[index]);
                                Navigator.pop(context);
                              } else {
                                controller
                                    .getPaymentDetailUsingId(
                                        controller.allPaymentDetail[index])
                                    .then((value) =>
                                        addPaymentMethodModalBottomSheet(
                                                context,
                                                controller,
                                                isEdit,
                                                controller
                                                    .allPaymentDetail[index],
                                                value)
                                            .then((value) => controller
                                                .initPayments()
                                                .then((value) => controller
                                                    .setStatePaymentDetail)));
                              }
                            },
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isEdit
                                          ? controller.allPaymentDetail[index]
                                              .description
                                          : controller
                                              .specificPaymentDetail[index]
                                              .description,
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
              }),
            );
          },
        );
      },
    );
  }

  static Future<void> addPaymentMethodModalBottomSheet(
      BuildContext context, HomeLogic controller, bool isEdit,

      ///Jika isEdit true maka tidak boleh null
      [PaymentDetailModel? paymentDetail,
      PaymentTypeModel? currentlySelectedPaymentType]) async {
    PaymentTypeModel? selectedPayment;
    final _formKey = GlobalKey<FormState>();
    if (isEdit &&
        paymentDetail != null &&
        currentlySelectedPaymentType != null) {
      controller.paymentDetailController[0].text = paymentDetail.description;
      controller.paymentDetailController[1].text =
          currentlySelectedPaymentType.paymentName;
      selectedPayment = currentlySelectedPaymentType;
    }
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
                        !isEdit ? "Add Payment Method" : "Edit Payment Method",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      isEdit
                          ? IconButton(
                              onPressed: () async {
                                Dialogs.deletePaymentMethodDialog(
                                    context, controller, paymentDetail!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 24.0,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {},
                              icon: Icon(
                                Icons.delete,
                                size: 24.0,
                                color: ColorTheme.COLOR_WHITE.withOpacity(0),
                              ),
                            ),
                      IconButton(
                        onPressed: () async {
                          if (selectedPayment != null) {
                            if (!isEdit) {
                              if (_formKey.currentState!.validate()) {
                                controller
                                    .insertPaymentDetail(selectedPayment!);
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                controller.editPaymentDetail(PaymentDetailModel(
                                    id: paymentDetail!.id,
                                    paymentTypeId: selectedPayment!.id,
                                    description: controller
                                        .paymentDetailController[0].text));
                              }
                            }
                          } else {
                            Get.snackbar('Error', 'Please choose payment type',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
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
                  if (selectedPayment != null) {
                    if (!isEdit) {
                      if (_formKey.currentState!.validate()) {
                        controller.insertPaymentDetail(selectedPayment!);
                      }
                    } else {
                      if (_formKey.currentState!.validate()) {
                        controller.editPaymentDetail(PaymentDetailModel(
                            id: paymentDetail!.id,
                            paymentTypeId: selectedPayment!.id,
                            description:
                                controller.paymentDetailController[0].text));
                      }
                    }
                  } else {
                    Get.snackbar('Error', 'Please choose payment type',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                },
                icon: const Icon(
                  Icons.check,
                  size: 24.0,
                ),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomTextFieldOld(
                    controller: controller.paymentDetailController[0],
                    keyboardType: TextInputType.text,
                    validation: true,
                    label: "Payment Method *",
                  ),
                  CustomTextFieldOld(
                    controller: controller.paymentDetailController[1],
                    onTap: () {
                      paymentTypeModalBottomSheet(context, controller, false,
                          (paymentType) {
                        selectedPayment = paymentType;
                        controller.paymentDetailController[1].text =
                            paymentType.paymentName;
                        controller.setStatePaymentDetail.value;
                      });
                    },
                    validation: true,
                    label: "Payment Type *",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void filterModalBottomSheet(
      BuildContext context,

      ///TransactionHistoryListLogic/TransactionReportLogic
      dynamic controller,
      void Function(int selectedFilter) onSelected) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            //Masukin setState bottomsheet ini ke GetX
            controller.setState.value ??= setState;
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
                            "Select Filter",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                      // controller.insertPaymentDetail();
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              body: Obx(
                () {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.filter.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onSelected(index);
                            Navigator.pop(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.filter[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> changeTaxModalBottomSheet(
    BuildContext context,
    // HomeLogic controller,
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
                          // controller.insertPaymentDetail();
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
                  // controller.insertPaymentDetail();
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
