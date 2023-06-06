import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

import '/utils/bottom_sheet.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    var item = "item";
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
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp.10000",
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
                                  Text(
                                    "Rp.10000",
                                    style: TextStyle(
                                      color: ColorTheme.COLOR_WHITE,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // ListTile(
                        //   leading: CircleAvatar(
                        //     backgroundColor: Colors.grey[200],
                        //     backgroundImage: const NetworkImage(
                        //       "https://i.ibb.co/QrTHd59/woman.jpg",
                        //     ),
                        //   ),
                        //   title: Text(controller.products.value[index].name),
                        //   subtitle: Text(controller.products.value[index].description),
                        //   // title: Text("Product Name"),
                        //   // subtitle: Text("Product Description"),
                        // ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BottomSheets.paymentTypeModalBottomSheet(
                                  context, (category) {});
                            },
                            child: Row(
                              children: [
                                Text("Payment Type"),
                                Spacer(),
                                Text("Transafer"),
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
                                Text("Cash"),
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
                                flex: 3,
                                child: Text("Total"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Rp. 40.000"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text("Tax 10%"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Rp. 4.000"),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text("Total Price"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Rp. 44.000"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
