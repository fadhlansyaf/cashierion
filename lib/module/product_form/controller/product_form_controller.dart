import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/state_util.dart';
import '../view/product_form_view.dart';


class ProductFormController extends State<ProductFormView> implements MvcController {
  static late ProductFormController instance;
  late ProductFormView view;
  File? _image;
  

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }


  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}