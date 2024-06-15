import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:orthotrade/common/widgets/loaders/loaders.dart';
import 'package:orthotrade/common/widgets/success_screen/success_screen.dart';
import 'package:orthotrade/utils/constants/image_strings.dart';
import 'package:orthotrade/utils/constants/text_strings.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email whenever verify screen appears and set timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    checkEmailVerificationStatus();
    super.onInit();
  }


  /// send email verification link

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MOLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email');
    } catch (e) {
      MOLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  ///Timer to automatically redirect on email verification

  void setTimerForAutoRedirect() {
    Timer.periodic(
        const Duration(seconds: 5),
            (timer) async {
          FirebaseAuth.instance.currentUser?.reload();
          final user = FirebaseAuth.instance.currentUser;
          if (user?.emailVerified ?? false) {
            timer.cancel();
            Get.off(() =>
                SuccessScreen(image: MOImages.successfullyRegisterAnimation,
                    title: MOTexts.yourAccountCreatedTitle,
                    subTitle: MOTexts.yourAccountCreatedSubTitle,
                    onPressed: () => AuthenticationRepository.instance.screenRedirect(FirebaseAuth.instance.currentUser)));
          }
        });
  }


///manually check if email verified

checkEmailVerificationStatus() async {

    final currentUser=FirebaseAuth.instance.currentUser;

    if(currentUser!=null && currentUser.emailVerified)
      {
      Get.off(
          () => SuccessScreen(image: MOImages.successfullyRegisterAnimation,
              title: MOTexts.yourAccountCreatedTitle,
              subTitle: MOTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect(FirebaseAuth.instance.currentUser))
      );
    }
}
}
