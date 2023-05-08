import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';

class SalesReportView extends StatelessWidget {
  const SalesReportView({Key? key}) : super(key: key);

  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("SalesReport"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}