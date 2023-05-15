import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';

class SalesTransactionView extends StatelessWidget {
  const SalesTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          var item = {};
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage(
                  "https://i.ibb.co/xgwkhVb/740922.png",
                ),
              ),
              title: const Text("Apple"),
              subtitle: const Text("15 USD"),
              trailing: SizedBox(
                width: 120.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 12.0,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 9.0,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 12.0,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
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
              ),
            ),
          );
        },
      ),
    );
  }
}
