import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/authentication/controllers/login/login_controller.dart';
import 'package:orthotrade/utils/networkconnection/network_manager.dart';
import 'package:orthotrade/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../password_configuration/forget_password.dart';

class MOLoginForm extends StatelessWidget {
  const MOLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(LoginController());
    Get.put(NetworkManager());

    return Form(
      key :controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MOSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              enabled: false,
              initialValue: 'shopnow.us@gmail.com',
              validator: (value)=>MOValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: MOTexts.email
              ) ,),
            const SizedBox(height: MOSizes.spaceBtwInputFields,),
            Obx(
                ()=> TextFormField(
                  enabled: false,
                  initialValue: 'Makers@321',
                validator: (value)=>MOValidator.validateEmptyText(MOTexts.password, value),
                obscureText: controller.hidePassword.value,
                decoration:  InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: MOTexts.password,
                    suffixIcon: IconButton(
                        onPressed: ()=>controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value? Iconsax.eye_slash:Iconsax.eye)),
                ) ,
                ),
            ),
            const SizedBox(height: MOSizes.spaceBtwInputFields/2),
            // Remember Me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(()=>Checkbox(value: controller.rememberMe.value, onChanged: (value)=>controller.rememberMe.value=!controller.rememberMe.value), ),
                    const Text(MOTexts.rememberMe),
                  ],
                ),
                // Forget Password
                TextButton(onPressed: () =>Get.to(()=>const ForgetPassword()),
                    child: const Text(MOTexts.forgetPassword))
              ],
            ),
            const SizedBox(height: MOSizes.spaceBtwInputFields),

            SizedBox(width: double.infinity,
                child: ElevatedButton(


                    onPressed: () =>  controller.emailAndPasswordSignIn(),
                    child: const Text(MOTexts.signIn))),
            const SizedBox(height: MOSizes.spaceBtwItems),

          /*      SizedBox(width: double.infinity,
                child: OutlinedButton(onPressed:(){
                   Get.to(()=>const SignUpScreen());
                },
                    child: const Text(MOTexts.createAccount)))*/
          ],

        ),
      ),
    );
  }
}