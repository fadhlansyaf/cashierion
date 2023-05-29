import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/product_form_controller.dart';

class SelectImageBottomSheet extends StatelessWidget {
  const SelectImageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final controller = Get.find<ProductFormLogic>();

    return Container(
      height: double.infinity,
      color: ColorTheme.COLOR_BACKGROUND,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.getImage(ImageSource.gallery);
                Navigator.pop(context);
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
                Navigator.pop(context);
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
            // ElevatedButton(
            //   child: const Text('Close BottomSheet'),
            //   onPressed: () => Navigator.pop(context),
            // ),
          ],
        ),
      ),
    );
  }
}
