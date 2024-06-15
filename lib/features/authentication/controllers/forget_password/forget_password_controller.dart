import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/common/widgets/loaders/loaders.dart';
import 'package:orthotrade/features/authentication/screens/password_configuration/reset_password.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/networkconnection/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';


class ForgetPasswordController extends GetxController{

  static ForgetPasswordController get instance => Get.find();

  /// Variables

final email =TextEditingController();

GlobalKey<FormState> forgetPasswordFormKey=GlobalKey<FormState>();


/// Send Reset Password Email
 sendPasswordResetEmail() async{
  try{


    //Start Loading
    MOFullScreenLoader.openLoadingDialog('Logging you in......', MOImages.docerAnimation);

    // Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      /// remove loader
      MOFullScreenLoader.stopLoading();
      return;
    }

    // Form Validation
    if (!forgetPasswordFormKey.currentState!.validate()) {
      MOFullScreenLoader.stopLoading();
      return;
    }


    // Send Forget Password email
    await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

    // Remove Loader
    MOFullScreenLoader.stopLoading();

    // Success Message
    MOLoaders.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password');

    //Redirect
    Get.to(()=>  ResetPasswordScreen(email:email.text.trim()));

  }
  catch(e)
  {
    MOFullScreenLoader.stopLoading();
    MOLoaders.errorSnackBar(title: 'Oh MOap',message: e.toString());
  }
}
  /// Send Reset Password Email
  resendPasswordResetEmail(String email) async{
    try{


      //Start Loading
      MOFullScreenLoader.openLoadingDialog('Logging you in......', MOImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        /// remove loader
        MOFullScreenLoader.stopLoading();
        return;
      }

      // Send  email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      MOFullScreenLoader.stopLoading();

      // Success Message
      MOLoaders.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password');

    }
    catch(e)
    {
      MOFullScreenLoader.stopLoading();
      MOLoaders.errorSnackBar(title: 'Oh MOap',message: e.toString());
    }
  }

}