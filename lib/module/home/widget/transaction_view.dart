import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';
import 'package:pos_app_skripsi/utils/helper.dart';
import 'toggle_button.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeLogic>();
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 35,
        width: width - 10,
        decoration: BoxDecoration(
          color: ColorTheme.COLOR_PRIMARY,
          borderRadius: BorderRadius.circular(5),
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: ColorTheme.COLOR_WHITE.withOpacity(0),
          child: Text(
            "Next",
            style: TextStyle(color: ColorTheme.COLOR_WHITE),
          ),
          //child widget inside this button
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () {
            print("Button is pressed.");
            //task to execute when this button is pressed
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: ColorTheme.COLOR_PRIMARY,
              ),
              child: TransactionToggleButtons(
                title: 'Sample',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                // controller: controller,
                style: TextStyle(
                  color: ColorTheme.COLOR_WHITE,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorTheme.COLOR_WHITE,
                      size: 20,
                    ),
                    focusColor: ColorTheme.COLOR_WHITE,
                    hintStyle: TextStyle(
                      color: ColorTheme.COLOR_WHITE,
                    ),
                    hintText: 'search',
                    // suffixIcon: suffix,
                    fillColor: ColorTheme.COLOR_CARD,
                    // border:
                    // OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(32),
                    //     borderSide: BorderSide.none),
                    filled: true),
                onEditingComplete: () {
                  // if (onEditingComplete != null) {
                  //   onEditingComplete!(controller!.text);
                  // }
                },
                // onChanged: onChanged,
              ),
            ),
            Obx(() {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.categoryList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            controller.categoryList[index].name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 6 / 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemCount: controller.productList
                              .where((p0) =>
                          p0.productCategoryId ==
                              controller.categoryList[index].id)
                              .length,
                          itemBuilder: (BuildContext context, secondIndex) {
                            var products = controller.productList.where((p0) =>
                            p0.productCategoryId ==
                                controller.categoryList[index].id).toList();
                            return GestureDetector(
                              onTap: () async {},
                              //TODO: Ganti warna product kalo quantity udah lebih dari satu (dhanis)
                              //Pake validasi products[secondIndex].quantity.value.obs > 0 aja
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: ColorTheme.COLOR_CARD,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            backgroundImage: null,
                                            radius: 15,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                products[secondIndex].name,
                                                // style: TextStyle(
                                                //   fontSize: ,
                                                // ),
                                              ),
                                              //TODO: Ganti harga tergantung order/restock
                                              Text(
                                                FunctionHelper
                                                    .convertPriceWithComma(
                                                    products[secondIndex]
                                                        .sellingPrice),
                                                style: TextStyle(
                                                  color: ColorTheme.COLOR_GREY,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                          ColorTheme.COLOR_PRIMARY,
                                          radius: 12.0,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                if(products[secondIndex].quantity
                                                    .value > 0) {
                                                  products[secondIndex].quantity
                                                    .value--;
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 9.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Obx(() {
                                            return Text(
                                              products[secondIndex].quantity
                                                  .value.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            );
                                          }),
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                          ColorTheme.COLOR_PRIMARY,
                                          radius: 12.0,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                if(products[secondIndex].quantity
                                                    .value < products[secondIndex].stock) {
                                                  products[secondIndex].quantity
                                                    .value++;
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 9.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
