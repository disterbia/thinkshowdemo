import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

import 'colors.dart';

final ThemeData appThemeDataLight = ThemeData(
  primaryColor: MyColors.primary,
  splashColor: MyColors.primary,
  highlightColor: MyColors.grey1,
  backgroundColor: MyColors.white,
  brightness: Brightness.light,
  // primarySwatch: createMaterialColor(MyColors.primary),
  colorScheme: const ColorScheme.light(
    primary: MyColors.primary,
    // primaryVariant: MyColors.primary,
    secondary: MyColors.secondary,
    // secondaryVariant: Color(0xffFFE800),
    surface: Colors.red,
    background: Colors.white,
    error: MyColors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: MyColors.primary,
      fixedSize: Size(100, 30),
      textStyle: MyTextStyles.f14.copyWith(color: Colors.white),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(MyColors.primary),
  ),
);
