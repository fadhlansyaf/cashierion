import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../controller/product_list_controller.dart';
import 'package:cashierion/module/product_form/controller/product_form_binding.dart';

import 'package:cashierion/module/product_detail/controller/product_detail_binding.dart';

import '/widgets/search_appbar.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListLogic>();
    List<ProductModel> duplicate = [];
    duplicate.addAll(controller.products);

    return Scaffold(
      appBar: SearchAppBar(
        title: Title(
          color: ColorTheme.COLOR_WHITE,
          child: Text("Products"),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            List<ProductModel> searched = [];
            for (var e in controller.products) {
              if (e.name.toLowerCase().contains(value.toLowerCase())) {
                searched.add(e);
              } else if (e.name != null) {
                if (e.name!.toLowerCase().contains(value.toLowerCase())) {
                  searched.add(e);
                }
              }
            }
            controller.products.clear();
            controller.products.addAll(searched);
          } else {
            controller.products.clear();
            controller.products.addAll(duplicate);
          }
        },
        height: MediaQuery.of(context).size.height * 0.14,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.COLOR_PRIMARY,
        child: const Icon(
          Icons.add,
          color: ColorTheme.COLOR_WHITE,
        ),
        onPressed: () async {
          Get.to(() => ProductFormPage(), binding: ProductFormBinding())
              ?.then((value) => controller.onInit());
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.products.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Get.to(
                          ProductDetailPage(
                            product: controller.products[index],
                          ),
                          binding: ProductDetailBinding())
                      ?.then((value) => controller.onInit());
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage:
                              controller.products[index].image.isNotEmpty
                                  ? MemoryImage(base64Decode(
                                      controller.products[index].image))
                                  : null,
                          radius: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.products[index].name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.products[index].description,
                              style: TextStyle(
                                color: ColorTheme.COLOR_GREY,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Stock: " +
                                  controller.products[index].stock.toString(),
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ListTile(
                  //   leading: CircleAvatar(
                  //     backgroundColor: Colors.grey[200],
                  //     backgroundImage: const NetworkImage(
                  //       "https://i.ibb.co/QrTHd59/woman.jpg",
                  //     ),
                  //   ),
                  //   title: Text(controller.products.value[index].name),
                  //   subtitle: Text(controller.products.value[index].description),
                  //   // title: Text("Product Name"),
                  //   // subtitle: Text("Product Description"),
                  // ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
