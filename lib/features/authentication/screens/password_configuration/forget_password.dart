import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:orthotrade/utils/constants/text_strings.dart';
import 'package:orthotrade/utils/validators/validation.dart';

import '../../../../utils/constants/sizes.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MOSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(MOTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: MOSizes.spaceBtwItems),
            Text(MOTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: MOSizes.spaceBtwSections * 2),

            /// Text Field
            Form(
              key: controller.forgetPasswordFormKey,

              child: TextFormField(
                controller:controller.email,
                  validator: MOValidator.validateEmail,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: MOTexts.email)),
            ),
            const SizedBox(height: MOSizes.spaceBtwSections),

            /// Submit Button

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () =>controller.sendPasswordResetEmail(), child: const Text(MOTexts.submit)))
          ],
        ),
      ),
    );
  }
}
