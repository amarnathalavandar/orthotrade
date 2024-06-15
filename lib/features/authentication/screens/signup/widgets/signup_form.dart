import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/authentication/screens/signup/widgets/terms_and_conditions.dart';


import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../verify_email.dart';
class MOSignupForm extends StatelessWidget {
  const MOSignupForm({
    super.key

  });
  @override
  Widget build(BuildContext context) {
    //final dark = SNHelperFunctions.isDarkMode(context);
    return Form(child:
    Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: MOTexts.firstName,prefixIcon:Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: MOSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: MOTexts.lastName,prefixIcon:Icon(Iconsax.user)),
                ),
              ),

            ],
          ),
          const SizedBox(height: MOSizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: MOTexts.username,prefixIcon:Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: MOSizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: MOTexts.email,prefixIcon:Icon(Iconsax.direct)),
          ),
          const SizedBox(height: MOSizes.spaceBtwInputFields),

          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: MOTexts.phoneNo,prefixIcon:Icon(Iconsax.call)),
          ),
          const SizedBox(height: MOSizes.spaceBtwInputFields),

          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: MOTexts.password,
                prefixIcon:Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash)
            ),
          ),
          const SizedBox(height: MOSizes.spaceBtwSections),
          const MOTermsAndConditions(),
          const SizedBox(height: MOSizes.spaceBtwSections),

          // Sign Up Button
          SizedBox(width: double.infinity,child: ElevatedButton(
            onPressed: () => Get.to(() => const VerifyEmailScreen()), child: const Text(MOTexts.createAccount),
          ),),
        ]
    )

    );
  }
}

