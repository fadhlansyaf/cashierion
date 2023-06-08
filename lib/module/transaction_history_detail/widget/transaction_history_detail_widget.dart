import 'package:flutter/material.dart';

import '../../../theme/theme_constants.dart';

class TransactionHistoryDetailWidget extends StatelessWidget {
  const TransactionHistoryDetailWidget(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
