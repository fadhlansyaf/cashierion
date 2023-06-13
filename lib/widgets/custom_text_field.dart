import 'package:flutter/material.dart';
import 'package:cashierion/theme/theme_constants.dart';

///Custom TextField, jika [onTap] null maka menampilkan textfield biasa,
///jika [onTap] tidak null maka menampilkan suffix icon, jika
class CustomTextFieldOld extends StatelessWidget {
  const CustomTextFieldOld(
      {Key? key,
      required this.controller,
      this.keyboardType,
      required this.label,
      this.validation,
      this.helperText,
      this.onTap,
      this.suffixIcon = const Icon(
        Icons.arrow_drop_down,
        color: ColorTheme.COLOR_PRIMARY,
      ),
      this.onSaved})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String label;
  final Function(String?)? validation;
  final String? helperText;
  final Function()? onTap;
  final Icon suffixIcon;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    if (onTap != null && controller.text.isEmpty) {
      if (suffixIcon ==
          Icon(
            Icons.arrow_drop_down,
            color: ColorTheme.COLOR_PRIMARY,
          )) {
        controller.text = 'Pilih salah satu';
      }
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: keyboardType,
        controller: controller,
        onTap: onTap,
        readOnly: onTap != null,
        // validator: validation,
        cursorColor: ColorTheme.COLOR_PRIMARY,
        decoration: InputDecoration(
            helperText: helperText,
            labelText: label,
            labelStyle: TextStyle(color: ColorTheme.COLOR_GREY),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: ColorTheme.COLOR_CARD,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorTheme.COLOR_WHITE),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorTheme.COLOR_PRIMARY),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0.25,
              ),
            ),
            suffixIcon: onTap != null ? suffixIcon : null),
      ),
    );
  }
}
