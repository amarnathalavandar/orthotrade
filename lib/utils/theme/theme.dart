import 'package:flutter/material.dart';
import 'custom_themes/text_theme.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';

class MOAppTheme{

  MOAppTheme._();

  static ThemeData lightTheme=ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MOTextTheme.lightTextTheme,
    chipTheme: MOChipTheme.lightChipTheme,
    checkboxTheme: MOCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MOBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: MOOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MOTextFormFieldTheme.lightTextFormFieldTheme,
    elevatedButtonTheme: MOElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: MOAppBarTheme.lightAppBarTheme,

    );//

  static ThemeData darkTheme =ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: MOTextTheme.darkTextTheme,
    chipTheme: MOChipTheme.darkChipTheme,
    checkboxTheme: MOCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MOBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: MOOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MOTextFormFieldTheme.darkTextFormFieldTheme,
    elevatedButtonTheme: MOElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: MOAppBarTheme.lightAppBarTheme,
  );

}