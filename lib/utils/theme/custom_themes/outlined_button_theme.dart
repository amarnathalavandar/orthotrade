import 'package:flutter/material.dart';

class MOOutlinedButtonTheme{

  MOOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(

    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side:  BorderSide(color: Colors.red..shade300),
      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.black),
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(

      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.blue),
          textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )
  );
}