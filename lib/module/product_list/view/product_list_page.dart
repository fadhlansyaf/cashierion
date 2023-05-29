import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/product_list_controller.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_binding.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.COLOR_PRIMARY,
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.to(() => ProductFormPage(), binding: ProductFormBinding())
              ?.then((value) => controller.onInit());
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          return ListView.builder(
            // itemCount: controller.products.value.length,
            itemCount: 1,

            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              var item = "item";
              return GestureDetector(
                onTap: () async {
                        await Get.to(
                            ProductFormPage(), binding: ProductFormBinding());
                      },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: const NetworkImage(
                        "https://i.ibb.co/QrTHd59/woman.jpg",
                      ),
                    ),
                    // title: Text(controller.products.value[index].name),
                    // subtitle: Text(controller.products.value[index].description),
                    title: Text("Product Name"),
                    subtitle: Text("Product Description"),
                    // trailing: IconButton(
                    //   onPressed: () async {
                    //     // await OldGet.to(const ProductFormPage(
                    //     // ));
                    //     await Get.to(
                    //         ProductFormPage(), binding: ProductFormBinding());
                    //   },
                    //   icon: const Icon(
                    //     Icons.edit,
                    //     size: 24.0,
                    //   ),
                    // ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
