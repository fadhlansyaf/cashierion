import 'package:flutter/material.dart';

import '../../../theme/theme_constants.dart';

class CategoryDetailWidget extends StatelessWidget {
  const CategoryDetailWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorTheme.COLOR_WHITE,
            width: 0.75
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: ColorTheme.COLOR_PRIMARY, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: TextStyle(
                color: ColorTheme.COLOR_WHITE, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
