import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';

import '../controller/product_list_controller.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_binding.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<ProductListLogic>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductList"),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(ProductFormPage(),binding: ProductFormBinding());
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  var item = "item";
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: const NetworkImage(
                          "https://i.ibb.co/QrTHd59/woman.jpg",
                        ),
                      ),
                      title: const Text("Jessica Doe"),
                      subtitle: const Text("Programmer"),
                      trailing: IconButton(
                        onPressed: () async {
                          // await OldGet.to(const ProductFormPage(
                          // ));
                          await Get.to(ProductFormPage(),binding: ProductFormBinding());
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 24.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
