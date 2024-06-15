import 'package:flutter/material.dart';
import 'package:orthotrade/features/authentication/screens/signup/widgets/signup_form.dart';


import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MOSizes.defaultSpace),
          child: Column(
            children: [
              Text(MOTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: MOSizes.spaceBtwSections),
              /// SignUp Form
              const MOSignupForm(),
              const SizedBox(height: MOSizes.spaceBtwSections),
              /// Divider
              //SNFormDivider(dividerText: MOTexts.orSignUpWith.capitalize!),
              //const SizedBox(height: MOSizes.spaceBtwSections),
              /// Social Buttons
            //  const SNSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


