import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'sales_transaction_view.dart';
import 'sales_transaction_detail.dart';

class SalesTransactionNavView extends StatelessWidget {
  var _pages = [SalesTransactionView(),SalesTransactionDetailView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SalesTransaction"),
        actions: const [],
      ),
      body: PageView(
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.blue[600],
        padding: const EdgeInsets.all(20.0),
        child: Wrap(children: [
          Row(
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                child: Text(
                  "Count here",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text("Checkout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {},
            ),
          )
        ]),
      ),
    );
  }
}
