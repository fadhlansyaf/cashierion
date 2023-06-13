import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/store_profile_form/controller/store_profile_form_binding.dart';
import 'package:cashierion/module/store_profile_form/view/store_profile_form_page.dart';
import 'package:cashierion/utils/dialog.dart';

import 'profile_detail_widget.dart';
import '/utils/bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    var controller = Get.find<HomeLogic>();
    bool isEdit = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                      () =>
                      StoreProfileFormPage(
                        // product: product,
                        isEditing: true,
                        // categories:
                      ),
                  binding: StoreProfileFormBinding())?.then((value) =>
                  controller.onInit());
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                flex: 11,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProfileDetailWidget(
                            title: 'Store Name',
                            subtitle: controller.storeName.value,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ProfileDetailWidget(
                            title: 'Phone Number',
                            subtitle: controller.phoneNumber.value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProfileDetailWidget(
                        title: 'Address', subtitle: controller.address.value),
                    SizedBox(
                      height: 10,
                    ),
                    ProfileDetailWidget(
                        title: 'Description',
                        subtitle: controller.description.value),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ElevatedButton(
                        onPressed: () {
                          Dialogs.addTaxDialog(context, controller);
                        },
                        child: Text("Edit Tax"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ElevatedButton(
                        onPressed: () {
                          BottomSheets.paymentTypeModalBottomSheet(
                              context, controller, isEdit, (paymentType) {});
                        },
                        child: Text("Edit Payment Type"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ElevatedButton(
                        onPressed: () {
                          BottomSheets.paymentMethodModalBottomSheet(
                              context, controller, isEdit, (paymentDetail) {});
                        },
                        child: Text("Edit Payment Method"),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Dialogs.deleteAllDataDialog(context, controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
