import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/networkconnection/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController
{
  static LoginController get instance => Get.find();

  /// Variables
  final rememberMe =false.obs;
  final hidePassword =true.obs;
  final  localStorage=GetStorage();
  final email = TextEditingController(text:'payfond.us@gmail.com');
  final password = TextEditingController(text:'Makers@321');
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  @override
  void onInit() {
    super.onInit();
  email.text = localStorage.read('REMEMBER_ME_EMAIL')?? '' ;
  password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  /// Email and Password Sign In
Future<void> emailAndPasswordSignIn() async
{
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
    if (!loginFormKey.currentState!.validate()) {
      /// remove loader
      MOFullScreenLoader.stopLoading();
      return;
    }

    // Save data if Remember Me is selected
   if(rememberMe.value)
    {
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }
   print('-------------CALLING fetchUserRecord-------------');
   // await userController.fetchUserRecord();

    // Login user using Email & Password Authentication
    final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword('payfond.us@gmail.com', 'Makers@321');
    await userController.fetchUserRecord();

    // Assign user data to RxUser of UserController to use in app

   localStorage.write('USERID', userCredentials.user?.uid);



    // Remove Loader
    MOFullScreenLoader.stopLoading();


    // Redirect
    AuthenticationRepository.instance.screenRedirect(FirebaseAuth.instance.currentUser);

  } catch(e){
    MOFullScreenLoader.stopLoading();
    MOLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
  }

}

/// Google Sign in

/*
Future<void> googleSignIn() async{
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

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //save User Record
      await userController.saveUserRecord(userCredentials);

      // remove loader
       MOFullScreenLoader.stopLoading();

       // Redirect
      AuthenticationRepository.instance.screenRedirect();



    }
    catch(e){
      MOFullScreenLoader.stopLoading();
      SNLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }


}*/
}
