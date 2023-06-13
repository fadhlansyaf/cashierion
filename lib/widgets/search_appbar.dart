import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cashierion/theme/theme_constants.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
    double defaultBottomHeight = 100;
    if (bottomHeight == null) {
      defaultBottomHeight = MediaQuery.of(context).size.height * 0.2;
    }
    List<Widget> bottomWidgetSearch = [];
    Widget searchWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            focusColor: Colors.black,
            hintStyle: TextStyle(color: Colors.black, ),
            hintText: 'search',
            suffixIcon: suffix,
            fillColor: ColorTheme.COLOR_WHITE,
            // border:
            // OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
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
    );
    if (bottomAboveSearch) {
      bottomWidgetSearch.addAll(bottomWidget);
      bottomWidgetSearch.add(searchWidget);
    } else {
      bottomWidgetSearch.add(searchWidget);
      bottomWidgetSearch.addAll(bottomWidget);
    }
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Theme.of(context).primaryColor,
      //     statusBarIconBrightness:
      //         isLightMode ? Brightness.dark : Brightness.light),
      // backgroundColor: Theme.of(context).primaryColor,
      // foregroundColor: Theme.of(context).colorScheme.secondary,
      // flexibleSpace: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: bottomWidgetSearch,
      //     ),
      bottom: PreferredSize(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            // transform: Matrix4.translationValues(0, -20, 0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bottomWidgetSearch,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(bottomHeight ?? defaultBottomHeight),
      ),
      elevation: 0,
      toolbarHeight: 200,
      title: title,
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
