import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/theme/theme_constants.dart';

/// Flutter code sample for [ToggleButtons].

// class ToggleButtonsExampleApp extends StatelessWidget {
//   const ToggleButtonsExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ToggleButtonsSample(title: 'ToggleButtons Sample'),
//     );
//   }
// }

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
    // final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;

    return Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ToggleButtons(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selectedTransaction.length; i++) {
                _selectedTransaction[i] = i == index;
              }
            });
          },
          // borderRadius: const BorderRadius.all(Radius.circular(8)),
          // selectedBorderColor: Colors.red[700],
          selectedColor: ColorTheme.COLOR_WHITE,
          fillColor: ColorTheme.COLOR_ACTIVE,
          color: ColorTheme.COLOR_WHITE,
          // constraints: const BoxConstraints(
          //   minHeight: double.infinity,
          //   minWidth: MediaQuery.of(context).size.width,
          // ),
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
