import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/module/product_form/controller/product_form_dao.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '../controller/product_form_controller.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SearchAppBar(
      {Key? key,
      this.height,
      required this.title,
      this.actions,
      this.bottomAboveSearch = true,
      this.bottomHeight,
      this.bottomWidget = const [],
      this.suffix,
      this.onChanged,
      this.onEditingComplete,
      this.controller,
      this.context})
      : super(key: key);
  final BuildContext? context;
  final double? height;
  final Widget title;
  final List<Widget>? actions;
  final bool bottomAboveSearch;
  final double? bottomHeight;
  final List<Widget> bottomWidget;
  final Widget? suffix;
  final Function(String)? onChanged;
  final Function(String)? onEditingComplete;
  final TextEditingController? controller;

  @override
  Widget build(context) {
    // final controller = Get.find<ProductFormLogic>();

    double defaultBottomHeight = 0;
    if (bottomHeight == null) {
      defaultBottomHeight = MediaQuery.of(context).size.height * 0.1;
    }
    List<Widget> bottomWidgetSearch = [];
    Widget searchWidget = Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'search',
              hintStyle: TextStyle(color: Colors.black),
              suffixIcon: suffix,
              fillColor: ColorTheme.COLOR_WHITE,
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              // enabledBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(32),
              //     borderSide: BorderSide.none),
              filled: true),
          onEditingComplete: () {
            if (onEditingComplete != null) {
              onEditingComplete!(controller!.text);
            }
          },
          onChanged: onChanged,
        ),
      ),
    );

    if (bottomAboveSearch) {
      bottomWidgetSearch.addAll(bottomWidget);
      bottomWidgetSearch.add(searchWidget);
    } else {
      bottomWidgetSearch.add(searchWidget);
      bottomWidgetSearch.addAll(bottomWidget);
    }
    return AppBar(
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
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bottomWidgetSearch,
              ),
            ],
          ),
          preferredSize: Size.fromHeight(bottomHeight ?? defaultBottomHeight),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        actions: actions,
      );
  }

  double getHeight() {
    if (height == null && bottomWidget.isNotEmpty && context != null) {
      return MediaQuery.of(context!).size.height * 0.2;
    } else if (height == null) {
      return kToolbarHeight;
    } else {
      return height!;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(getHeight());
}
