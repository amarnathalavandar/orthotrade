import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

class MOLoaders extends GetxController
{

  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();


  static customToast({required message})
  {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
          duration: const Duration(seconds:3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MOHelperFunctions.isDarkMode(Get.context!)? MOColors.white : MOColors.light,

            ),
          ))
    );
  }

  static warningSnackBar({required title,message='',duration=3}){

    Get.snackbar(

        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon:const Icon(Iconsax.warning_2,color: MOColors.white)
    );
  }

  static successSnackBar({required title,message='',duration=3}){

    Get.snackbar(

        title,
        message,
    isDismissible: true,
    shouldIconPulse: true,
    colorText: Colors.white,
    backgroundColor: Colors.grey,
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(seconds: duration),
    margin: const EdgeInsets.all(10),
    icon:const Icon(Iconsax.check,color: MOColors.white)
    );
    }

  static errorSnackBar({required title,message=''}){

    Get.snackbar(

        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade500,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon:const Icon(Iconsax.warning_2,color: MOColors.white)
    );
  }


}
