import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/theme/theme_constants.dart';

/// Flutter code sample for [ToggleButtons].


class TransactionToggleButtons extends StatefulWidget {
  const TransactionToggleButtons({super.key, required this.title});

  final String title;

  @override
  State<TransactionToggleButtons> createState() =>
      _TransactionToggleButtonsState();
}

class _TransactionToggleButtonsState extends State<TransactionToggleButtons> {
  final List<bool> _selectedTransaction = <bool>[true, false];
  bool vertical = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var controller = Get.find<HomeLogic>();
    return Column(
      children: <Widget>[
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selectedTransaction.length; i++) {
                _selectedTransaction[i] = i == index;
                //Jika i = 0 (Order) maka set isOrder value pada controller
                if(i == 0){
                  controller.isOrder.value = i == index;
                }
              }
            });
          },
          selectedColor: ColorTheme.COLOR_WHITE,
          fillColor: ColorTheme.COLOR_ACTIVE,
          color: ColorTheme.COLOR_WHITE,
          isSelected: _selectedTransaction,
          children: [
            Container(
              width: (width - 3) / 2,
              alignment: Alignment.center,
              child: Text(
                'Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: (width - 3) / 2,
              alignment: Alignment.center,
              child: Text(
                'Restock',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
