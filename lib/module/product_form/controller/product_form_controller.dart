import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormLogic extends GetxController {
  var selectedIndex = 0.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value=pickedFile.path;
      selectedImageSize.value=((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // File? _image;

  // Future getImage() async {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);

  //     _image = imageTemporary;

  //     // controller.setState(() {
  //     //   _image = imageTemporary;
  //     // });
  //   }

  // Future test() async {
  //   var test = 0;
  //   stderr.writeln(test);
  // }
}
