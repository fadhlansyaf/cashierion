import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';
import 'package:pos_app_skripsi/module/product_form/widget/category_bottom_sheet.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../module/product_form/widget/search_appbar.dart';

class BottomSheets {
  const BottomSheets({Key? key});

  static Future<dynamic> categoryModalBottomSheet(context) async {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: SearchAppBar(
            title: Title(
              color: ColorTheme.COLOR_WHITE,
              child: Text("Search Category"),
            ),
            height: MediaQuery.of(context).size.height * 0.175,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Add Category"),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  shrinkWrap: true,
                  // primary: false,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    var item = "item";
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Jessica Doe",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  static Widget CategoryBottomSheet(context) {
    // final controller = Get.find<ProductFormLogic>();

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Search Category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(100),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
      ),
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          var item = "item";
          return Card(
            child: ListTile(
              title: const Text("Jessica Doe"),
            ),
          );
        },
      ),
    );
  }

  // @override
  // Size get preferredSize => Size.fromHeight(getHeight());
}
