import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';
import 'package:pos_app_skripsi/utils/helper.dart';

import '/utils/bottom_sheet.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeLogic>();
    var selectedProducts =
        controller.productList.where((p0) => p0.quantity > 0).toList();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // await Get.to(ProductDetailPage(product: controller.products[index],),
                      //     binding: ProductDetailBinding())?.then((value) => controller.onInit());
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: null,
                              radius: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProducts[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //TODO: ganti price sesuai order/restock
                                Text(
                                  '${FunctionHelper.convertPriceWithComma(selectedProducts[index].sellingPrice)} x ${selectedProducts[index].quantity}',
                                  style: TextStyle(
                                    color: ColorTheme.COLOR_WHITE,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                //TODO: ganti price sesuai order/restock
                                Text(
                                  FunctionHelper.convertPriceWithComma(
                                      selectedProducts[index].sellingPrice *
                                          selectedProducts[index]
                                              .quantity
                                              .value),
                                  style: TextStyle(
                                    color: ColorTheme.COLOR_WHITE,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BottomSheets.paymentTypeModalBottomSheet(
                                  context, controller, (category) {});
                            },
                            child: Row(
                              children: [
                                Expanded(child: Text("Payment Type")),
                                Text(controller
                                    .selectedPaymentType.value.paymentName),
                                Icon(
                                  Icons.edit,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              BottomSheets.paymentMethodModalBottomSheet(
                                  context, (category) {});
                            },
                            child: Row(
                              children: [
                                Text("Payment Method"),
                                Spacer(),
                                Text("Test"),
                                Icon(
                                  Icons.edit,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("Total"),
                              ),
                              Text(FunctionHelper.convertPriceWithComma(
                                  controller.countTotal(selectedProducts))),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Tax 10%"),
                              ),
                              Text(FunctionHelper.convertPriceWithComma(
                                  controller.tax.value)),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Total Price")),
                              Text(FunctionHelper.convertPriceWithComma(
                                  controller.countTotal(selectedProducts) +
                                      controller.tax.value)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // addCategoryModalBottomSheet(
                        //         context, categoryFormController)
                        //     .then((value) => controller
                        //         .onInit()
                        //         .then((value) => controller.setState));
                      },
                      child: Text("Create Transaction"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.COLOR_DISABLED),
                      onPressed: () {},
                      child: Text(
                        "Create Transaction",
                        style: TextStyle(color: ColorTheme.COLOR_TEXT_DISABLED),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
