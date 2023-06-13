import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/module/product_form/controller/product_form_dao.dart';
import 'package:cashierion/theme/theme_constants.dart';

import '../controller/product_form_controller.dart';

class SelectImageDialog extends StatelessWidget {
  const SelectImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final controller = Get.find<ProductFormLogic>();

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Text(
                    "Select Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Gallery"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Camera"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center),
                  ),
                ),
              ],
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
