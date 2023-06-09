import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'package:pos_app_skripsi/module/store_profile_form/controller/store_profile_form_binding.dart';
import 'package:pos_app_skripsi/module/store_profile_form/view/store_profile_form_page.dart';

import 'profile_detail_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(
                  () => StoreProfileFormPage(
                        // product: product,
                        isEditing: true,
                        // categories:
                      ),
                  binding: StoreProfileFormBinding());
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ProfileDetailWidget(
                          title: 'Store Name',
                          subtitle: 'Store Name',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ProfileDetailWidget(
                          title: 'Phone Number',
                          subtitle: 'Phone Number',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileDetailWidget(title: 'Address', subtitle: 'Address'),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileDetailWidget(
                      title: 'Description', subtitle: 'Description'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Edit Tax"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Edit Payment Type"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Edit Payment Method"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
