import 'package:flutter/material.dart';

class ColorTheme {
  static const COLOR_PRIMARY = Color.fromARGB(255, 239, 131, 84); //EF8354
  static const COLOR_BACKGROUND = Color.fromARGB(255, 45, 49, 66); //2D3142
  static const COLOR_CARD = Color.fromARGB(255, 79, 93, 117); //4F5D75
  static const COLOR_ACTIVE = Color.fromARGB(255, 236, 88, 24); //EC5818

  static const COLOR_GREY = Color.fromARGB(255, 191, 192, 192); //BFC0C0
  static const COLOR_WHITE = Color.fromARGB(255, 255, 255, 255); //FFFFFF
}



ThemeData lightTheme = ThemeData(
  brightness: Brightness.light
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
);

ThemeData mainTheme = ThemeData(
  primaryColor: ColorTheme.COLOR_PRIMARY,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: ColorTheme.COLOR_WHITE),
    displayMedium: TextStyle(color: ColorTheme.COLOR_WHITE),
    displaySmall: TextStyle(color: ColorTheme.COLOR_WHITE)
  ),
  appBarTheme:  AppBarTheme(
    color: ColorTheme.COLOR_PRIMARY,
  ),
  cardColor: ColorTheme.COLOR_CARD,
  scaffoldBackgroundColor: ColorTheme.COLOR_BACKGROUND,
);