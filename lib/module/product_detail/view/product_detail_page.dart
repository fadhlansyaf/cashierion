import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_detail/controller/product_detail_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import 'package:pos_app_skripsi/module/product_form/controller/product_form_binding.dart';

import '../controller/product_detail_controller.dart';
import '../widget/product_detail_widget.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductDetail"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                      () => ProductFormPage(
                          product: product,
                          isEditing: true,
                          categories: controller.categoryList),
                      binding: ProductFormBinding())
                  ?.then((value) => controller.onInit());
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                      'This action will permanently delete this data'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: ColorTheme.COLOR_PRIMARY),
                      ),
                    ),
                  ],
                ),
              );
              if(result == true){
                controller.deleteItem(product);
              }
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProductDetailLogic>(builder: (logic) {
          if (!logic.isLoading.value) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  product.image.isEmpty
                        ? Column(
                            children: [
                              Image.asset("assets/select-image.png"),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width) / 2,
                                child: Image.memory(base64Decode(product.image)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  SizedBox(
                    height: 40,
                  ),
                  ProductDetailWidget(
                      title: 'Product Name', subtitle: product.name),
                  SizedBox(
                    height: 20,
                  ),
                  ProductDetailWidget(
                      title: 'Category',
                      subtitle: logic.categoryList
                              .firstWhereOrNull(
                                  (p0) => p0.id == product.productCategoryId)
                              ?.name ??
                          ''),
                  SizedBox(
                    height: 20,
                  ),
                  ProductDetailWidget(
                      title: 'Price', subtitle: product.price.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  ProductDetailWidget(
                      title: 'Selling Price',
                      subtitle: product.sellingPrice.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  ProductDetailWidget(
                      title: 'Stock', subtitle: product.stock.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  ProductDetailWidget(
                      title: 'Description', subtitle: product.description),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }

// @override
// State<ProductFormPage> createState() => ProductFormController();
}
