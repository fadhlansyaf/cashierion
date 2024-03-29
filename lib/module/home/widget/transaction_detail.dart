import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/theme/theme_constants.dart';
import 'package:cashierion/utils/helper.dart';

import '/utils/bottom_sheet.dart';

///Halaman transaction detail
class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeLogic>();
    var selectedProducts =
        controller.productList.where((p0) => p0.quantity > 0).toList();
    controller.countTotal(selectedProducts);
    bool isEdit = false;
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
                              backgroundImage:
                                  selectedProducts[index].image.isNotEmpty
                                      ? MemoryImage(base64Decode(
                                          selectedProducts[index].image))
                                      : null,
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
                                Text(
                                  '${FunctionHelper.convertPriceWithComma(controller.isOrder.value ? selectedProducts[index].sellingPrice : selectedProducts[index].price)} x ${selectedProducts[index].quantity}',
                                  style: TextStyle(
                                    color: ColorTheme.COLOR_WHITE,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (selectedProducts[index]
                                    .transactionDesc
                                    .isNotEmpty)
                                  SizedBox(
                                    child: Text(
                                      selectedProducts[index].transactionDesc,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ColorTheme.COLOR_WHITE,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FunctionHelper.convertPriceWithComma(
                                      controller.isOrder.value
                                          ? selectedProducts[index]
                                                  .sellingPrice *
                                              selectedProducts[index]
                                                  .quantity
                                                  .value
                                          : selectedProducts[index].price *
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
                      child: Obx(() {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BottomSheets.paymentTypeModalBottomSheet(
                                    context, controller, isEdit, (paymentType) {
                                  controller.selectedPaymentType.value =
                                      paymentType;
                                  controller
                                      .reinitializeSelectedPaymentDetail();
                                });
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
                            if (controller.specificPaymentDetail.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    BottomSheets.paymentMethodModalBottomSheet(
                                        context, controller, isEdit,
                                        (paymentDetail) {
                                      controller.selectedPaymentDetail.value =
                                          paymentDetail;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Payment Method")),
                                      Text(controller.selectedPaymentDetail
                                              .value?.description ??
                                          ''),
                                      Icon(
                                        Icons.edit,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                  Card(
                    child: Obx(() {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Total"),
                                ),
                                Text(FunctionHelper.convertPriceWithComma(
                                    controller.totalAmount.value)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Tax ${controller.tax.value}%"),
                                ),
                                Text(FunctionHelper.convertPriceWithComma(
                                    controller.taxTotal.value)),
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Total Price")),
                                Text(FunctionHelper.convertPriceWithComma(
                                    controller.totalAmount.value +
                                        controller.taxTotal.value)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedProducts.isNotEmpty
                          ? () {
                              controller.insertTransaction(pageController);
                              Get.snackbar(
                                'Success',
                                'Transaction has been successfully inserted',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                margin: EdgeInsets.only(top: 20.0),
                              );
                            }
                          : null,
                      child: Text("Create Transaction"),
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
