import 'package:flutter/material.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image,title,subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MOSpacingStyle.paddingWithAppBarHeight*2,
          child: Column(
            children: [
              ///Image
              Image(image: AssetImage(image),
                width: MOHelperFunctions.screenWidth()*0.6,
              ),
              const SizedBox(height: MOSizes.spaceBtwSections,),
              /// Title and SubTitle
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: MOSizes.spaceBtwSections,),
              Text(subTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: MOSizes.spaceBtwSections,),

              /// Buttons
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: onPressed,child:  const Text(MOTexts.tContinue,)),
              )],
          ),
        ),

      ),


    );
  }
}
