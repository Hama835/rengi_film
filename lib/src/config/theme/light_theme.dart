import 'package:flutter/material.dart';
import 'package:rengi_filim/src/config/color/light_colors.dart';

final lightTheme = ThemeData(
  primaryColor: LightColors.primary,
  scaffoldBackgroundColor: LightColors.white,
  textTheme: TextTheme(
    titleMedium: TextStyle(fontSize: 16, color: LightColors.mutedBlack),
    bodyMedium: TextStyle(
        fontSize: 14,
        color: LightColors.mutedBlack,
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        fontSize: 20,
        color: LightColors.mutedBlack,
        fontWeight: FontWeight.bold),
  ),
  fontFamily: "UniSIRWAN_Adelle",
  hintColor: LightColors.grey,
  iconTheme: IconThemeData(color: LightColors.mutedBlack),
  appBarTheme: AppBarTheme(
      backgroundColor: LightColors.white, elevation: 0, toolbarHeight: 60),
  colorScheme: ColorScheme.light(
      background: LightColors.white,
      primary: LightColors.primary,
      secondary: LightColors.secondary),
);
