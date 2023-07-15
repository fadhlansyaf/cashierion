import 'dart:convert';
import 'package:cashierion/model/database/database_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/theme/theme_constants.dart';
import 'package:cashierion/utils/dialog.dart';
import 'package:cashierion/utils/helper.dart';
import 'toggle_button.dart';

///Keseluruhan halaman transaction
class TransactionView extends StatelessWidget {
  const TransactionView({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeLogic>();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<ProductModel> duplicate = [];
    duplicate.addAll(controller.productList);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: ColorTheme.COLOR_PRIMARY,
                    ),
                    child: TransactionToggleButtons(
                      title: 'Sample',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      // controller: controller,
                      style: TextStyle(
                        color: ColorTheme.COLOR_WHITE,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorTheme.COLOR_WHITE,
                            size: 20,
                          ),
                          focusColor: ColorTheme.COLOR_WHITE,
                          hintStyle: TextStyle(
                            color: ColorTheme.COLOR_WHITE,
                          ),
                          hintText: 'search',
                          // suffixIcon: suffix,
                          fillColor: ColorTheme.COLOR_CARD,
                          // border:
                          // OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                          // enabledBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(32),
                          //     borderSide: BorderSide.none),
                          filled: true),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          List<ProductModel> searched = [];
                          for (var e in controller.productList) {
                            if (e.name
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              searched.add(e);
                            } else if (e.name != null) {
                              if (e.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                                searched.add(e);
                              }
                            }
                          }
                          controller.productList.clear();
                          controller.productList.addAll(searched);
                        } else {
                          controller.productList.clear();
                          controller.productList.addAll(duplicate);
                        }
                      },
                    ),
                  ),
                  controller.productList.isNotEmpty
                      ? Obx(() {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.categoryList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        controller.categoryList[index].name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Obx(() {
                                      return GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                childAspectRatio: 6 / 4,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount: controller.productList
                                            .where((p0) =>
                                                p0.productCategoryId ==
                                                controller
                                                    .categoryList[index].id)
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            secondIndex) {
                                          var products = controller.productList
                                              .where((p0) =>
                                                  p0.productCategoryId ==
                                                  controller
                                                      .categoryList[index].id)
                                              .toList();
                                          return GestureDetector(
                                            onTap: () async {},
                                            child: Obx(() {
                                              return Ink(
                                                decoration: products[
                                                                secondIndex]
                                                            .stock >
                                                        0
                                                    ? products[secondIndex]
                                                                .quantity
                                                                .value
                                                                .obs >
                                                            0
                                                        ? BoxDecoration(
                                                            color: ColorTheme
                                                                .COLOR_PRIMARY,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))
                                                        : BoxDecoration(
                                                            color: ColorTheme
                                                                .COLOR_CARD,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))
                                                    : BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                child: InkWell(
                                                  onLongPress: () {
                                                    Dialogs
                                                        .productQuantityDialog(
                                                            context,
                                                            products[index]);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                backgroundImage: products[
                                                                            secondIndex]
                                                                        .image
                                                                        .isNotEmpty
                                                                    ? MemoryImage(
                                                                        base64Decode(
                                                                            products[secondIndex].image))
                                                                    : null,
                                                                radius: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    products[
                                                                            secondIndex]
                                                                        .name,
                                                                    // style: TextStyle(
                                                                    //   fontSize: ,
                                                                    // ),
                                                                  ),
                                                                  Text(
                                                                    FunctionHelper.convertPriceWithComma(controller
                                                                            .isOrder
                                                                            .value
                                                                        ? products[secondIndex]
                                                                            .sellingPrice
                                                                        : products[secondIndex]
                                                                            .price),
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorTheme
                                                                          .COLOR_GREY,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Stock: " +
                                                                        products[secondIndex]
                                                                            .stock
                                                                            .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorTheme
                                                                          .COLOR_GREY,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Obx(() {
                                                              return CircleAvatar(
                                                                backgroundColor: products[secondIndex]
                                                                            .stock >
                                                                        0
                                                                    ? products[secondIndex].quantity.value >
                                                                            0
                                                                        ? ColorTheme
                                                                            .COLOR_CARD
                                                                        : ColorTheme
                                                                            .COLOR_PRIMARY
                                                                    : products[secondIndex].quantity.value >
                                                                            0
                                                                        ? ColorTheme
                                                                            .COLOR_TEXT_DISABLED
                                                                        : ColorTheme
                                                                            .COLOR_TEXT_DISABLED,
                                                                radius: 15.0,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (products[secondIndex]
                                                                              .quantity
                                                                              .value >
                                                                          0) {
                                                                        products[secondIndex]
                                                                            .quantity
                                                                            .value--;
                                                                      }
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 9.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Obx(() {
                                                                return Text(
                                                                  products[
                                                                          secondIndex]
                                                                      .quantity
                                                                      .value
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                            Obx(() {
                                                              return CircleAvatar(
                                                                backgroundColor: products[secondIndex]
                                                                            .stock >
                                                                        0
                                                                    ? products[secondIndex].quantity.value >
                                                                            0
                                                                        ? ColorTheme
                                                                            .COLOR_CARD
                                                                        : ColorTheme
                                                                            .COLOR_PRIMARY
                                                                    : products[secondIndex].quantity.value >
                                                                            0
                                                                        ? ColorTheme
                                                                            .COLOR_TEXT_DISABLED
                                                                        : ColorTheme
                                                                            .COLOR_TEXT_DISABLED,
                                                                radius: 15.0,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (products[secondIndex].quantity.value <
                                                                              products[secondIndex]
                                                                                  .stock &&
                                                                          controller
                                                                              .isOrder
                                                                              .value) {
                                                                        products[secondIndex]
                                                                            .quantity
                                                                            .value++;
                                                                      } else if (!controller
                                                                          .isOrder
                                                                          .value) {
                                                                        products[secondIndex]
                                                                            .quantity
                                                                            .value++;
                                                                      }
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 9.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          );
                        })
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "No products available",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 35,
              width: width - 10,
              decoration: BoxDecoration(
                color: ColorTheme.COLOR_PRIMARY,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                child: Text(
                  "Next",
                  style: TextStyle(color: ColorTheme.COLOR_WHITE),
                ),
                //child widget inside this button
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  //task to execute when this button is pressed
                },
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
