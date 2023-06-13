import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/module/product_detail/controller/product_detail_dao.dart';
import 'package:cashierion/theme/theme_constants.dart';

import 'package:cashierion/module/product_form/controller/product_form_binding.dart';

import '../controller/product_detail_controller.dart';
import '../widget/product_detail_widget.dart';
import '/utils/dialog.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
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
              Dialogs.deleteProductsDialog(context, controller, product);
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
                              height: (MediaQuery.of(context).size.width) / 2,
                              child: Image.memory(
                                base64Decode(product.image),
                                fit: BoxFit.cover,
                              ),
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
