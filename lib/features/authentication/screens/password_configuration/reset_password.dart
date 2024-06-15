import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:orthotrade/features/authentication/screens/login/login.dart';
import 'package:orthotrade/utils/constants/image_strings.dart';
import 'package:orthotrade/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MOSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(image: const AssetImage(MOImages.deliveredEmailIllustration),
                width: MOHelperFunctions.screenWidth()*0.6,
              ),

              ///  Email , Title, SubTitle
              Text(email,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: MOSizes.spaceBtwItems),
              Text(MOTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: MOSizes.spaceBtwSections),
              Text(MOTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: MOSizes.spaceBtwSections),


              /// Done Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>Get.offAll(()=>const LoginScreen()), child: const Text(MOTexts.done))),
              const SizedBox(height: MOSizes.spaceBtwItems),


              /// Resent Email Text Button
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child :const Text(MOTexts.resendEmail)))

            ],
          )

        ),
      ),
    );
  }
}
