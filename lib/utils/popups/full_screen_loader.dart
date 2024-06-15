import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';
import '../../common/widgets/loaders/animation_loader.dart';


/// A Utility class for managing a full screen loading dialog
class MOFullScreenLoader{
  /// Open a full-screen loading dialog with a given text and animation
  /// this method doesnt return anything
  ///
  /// Parameters:
  ///  - text : Text to be displayed in the loading dialog
  ///  -animation : The Lottie animation to be shown

  static void openLoadingDialog(String text,String animation){
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false, // Disable popping with the back button
          child: Container(
            color: MOHelperFunctions.isDarkMode(Get.context!)? MOColors.dark:MOColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const  SizedBox(height: 250,),
                MOAnimationLoaderWidget(text: text,animation:animation),
              ],
            ),
          )
        )
    );
  }
  // stop the currently open loading dialog
  // this method doesn't return anything
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();// Close the dialog using navigator
  }
}