import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import 'transaction_view.dart';
import 'transaction_detail.dart';

class TransactionNavView extends StatelessWidget {
  static PageController pageController = PageController();
  final _pages = [TransactionView(pageController: pageController,),TransactionDetailView()];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        actions: const [],
        elevation: 0,
      ),
      body: PageView(
        controller: pageController,
        children: _pages,
      ),
      // bottomNavigationBar: Container(
      //   height: 90,
      //   color: Colors.blue[600],
      //   padding: const EdgeInsets.all(20.0),
      //   child: Wrap(children: [
      //     Row(
      //       children: [
      //         Text(
      //           "Total:",
      //           style: TextStyle(
      //             fontSize: 20.0,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         const Expanded(
      //           child: Text(
      //             "Count here",
      //             textAlign: TextAlign.right,
      //             style: TextStyle(
      //               fontSize: 20.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       height: 40,
      //       child: ElevatedButton.icon(
      //         icon: const Icon(Icons.check),
      //         label: const Text("Checkout"),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.green,
      //         ),
      //         onPressed: () {},
      //       ),
      //     )
      //   ]),
      // ),
    );
  }
}
