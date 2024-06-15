import 'package:flutter/material.dart';


class MOTextTheme{

  MOTextTheme._();

  //Customizable Light Text Theme

  static TextTheme lightTextTheme=TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0,fontWeight: FontWeight.bold,color:Colors.blueGrey),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color:Colors.blueGrey),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.blueGrey),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600,color:Colors.blueGrey),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500,color:Colors.blueGrey),
    titleSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400,color:Colors.black),

    bodyLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500,color:Colors.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 10.0, fontWeight: FontWeight.normal,color:Colors.black),
    bodySmall: const TextStyle().copyWith(fontSize: 8.0, fontWeight: FontWeight.w500,color:Colors.black),


   // labelLarge: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color:Colors.blue),
    //labelMedium: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color:Colors.black.withOpacity(0.5)),
  );


  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize:32.0,fontWeight: FontWeight.bold,color:Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color:Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.blue),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600,color:Colors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500,color:Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400,color:Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500,color:Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal,color:Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 8.0, fontWeight: FontWeight.w500,color:Colors.white),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color:Colors.blue),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color:Colors.white.withOpacity(0.5)),


  );





}