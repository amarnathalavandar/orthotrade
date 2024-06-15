import 'package:flutter/material.dart';
import 'package:orthotrade/common/styles/spacing_styles.dart';
import 'package:orthotrade/features/authentication/screens/login/widgets/login_form.dart';
import 'package:orthotrade/features/authentication/screens/login/widgets/login_header.dart';
import 'package:orthotrade/utils/constants/sizes.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: MOSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [


                // Logo, Title and Sub Title
                MOLoginHeader(),


                // Login Form with Sign-In Buttons
                SizedBox(height: MOSizes.spaceBtwSections),

                 MOLoginForm(),


                //Divider
                //Divider(color:SNColors.,)
                // Footer



              ],

            ),
            

                
        ),
      ),
    );
  }
}




