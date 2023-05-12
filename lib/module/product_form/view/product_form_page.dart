import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';

import '../controller/product_form_controller.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.find<ProductFormLogic>();
    final dao = Get.find<ProductFormDao>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.selectedImagePath.value == ''
                  ? Text(
                      'Select Image from camera/galery',
                      style: TextStyle(fontSize: 20),
                    )
                  : Image.file(File(controller.selectedImagePath.value))),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getImage(ImageSource.gallery);
                },
                child: Row(
                    children: [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Gallery"),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getImage(ImageSource.camera);
                },
                child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Camera"),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: controller.textController[0],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.textController[1],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.textController[1],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Selling Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.textController[2],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  await dao.insertItem(ProductsModel(
                      name: controller.textController[0].text,
                      price: double.parse(controller.textController[1].text),
                      sellingPrice: double.parse(controller.textController[1].text),
                      stock: 0,
                      description: controller.textController[2].text));
                  Get.back();
                },
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // State<ProductFormPage> createState() => ProductFormController();
}
