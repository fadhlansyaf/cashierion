import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(255, 239, 131, 84); //EF8354
const COLOR_BACKGROUND = Color.fromARGB(255, 45, 49, 66); //2D3142
const COLOR_CARD = Color.fromARGB(255, 79, 93, 117); //4F5D75
const COLOR_ACTIVE = Color.fromARGB(255, 236, 88, 24); //EC5818

const COLOR_GREY = Color.fromARGB(255, 191, 192, 192); //BFC0C0
const COLOR_WHITE = Color.fromARGB(255, 255, 255, 255); //FFFFFF


ThemeData lightTheme = ThemeData(
  brightness: Brightness.light
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
);

ThemeData mainTheme = ThemeData(
  primaryColor: COLOR_PRIMARY,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: COLOR_WHITE),
    displayMedium: TextStyle(color: COLOR_WHITE),
    displaySmall: TextStyle(color: COLOR_WHITE)
  ),
  appBarTheme:  AppBarTheme(
    color: COLOR_PRIMARY,
  ),
  cardColor: COLOR_CARD,
  scaffoldBackgroundColor: COLOR_BACKGROUND,
);