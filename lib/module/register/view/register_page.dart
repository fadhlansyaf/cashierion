import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/register_controller.dart';
import '/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key, this.isEditing = false, this.category})
      : super(key: key);
  final bool isEditing;
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterLogic>();
    if (isEditing && category != null) {
      controller.textController[0].text = category!.name;
      controller.textController[1].text = category!.description;
    }

    return Scaffold(
      // backgroundColor: Color(Gradient(colors: [ColorTheme.COLOR_ACTIVE, ColorTheme.COLOR_PRIMARY]),),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                ColorTheme.COLOR_ACTIVE,
                ColorTheme.COLOR_PRIMARY,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Image.asset(
                  "assets/logo-no-background.png",
                  width: 250,
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: ColorTheme.COLOR_BACKGROUND,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CustomTextFieldOld(
                            controller: controller.textController[0],
                            keyboardType: TextInputType.text,
                            label: "Store Name",
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Register"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // SingleChildScrollView(
        //   child: Container(
        //     padding: const EdgeInsets.all(10.0),
        //     child: Column(
        //       children: [
        //         CustomTextFieldOld(
        //           controller: controller.textController[0],
        //           keyboardType: TextInputType.text,
        //           label: "Store Name",
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}