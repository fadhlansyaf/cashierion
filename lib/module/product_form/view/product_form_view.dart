import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import '../controller/product_form_controller.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({Key? key}) : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;
    ImagePicker picker = new ImagePicker();

    File? _image;

    Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;

    final imageTemporary = File(image.path);

    controller.setState(() {
      _image = imageTemporary;
    });
  }

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
              _image != null ? Image.file(_image!,width: 250, height: 250, fit: BoxFit.cover,) :  Image.network("https://i.ibb.co/QrTHd59/woman.jpg"),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  title: 'Pick from Gallery',
                  icon: Icons.image_outlined,
                  onClick: () => getImage()),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Pick from Camera',
                icon: Icons.camera,
                onClick: () => {},
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
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
                label: const Text("save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {},
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

  @override
  State<ProductFormView> createState() => ProductFormController();
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: () => onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
