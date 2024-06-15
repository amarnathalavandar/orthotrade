import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class MOTermsAndConditions extends StatelessWidget {
 const MOTermsAndConditions({
    super.key
  });
  @override
  Widget build(BuildContext context) {
   // final dark =SNHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24,height: 24,child: Checkbox(value: true, onChanged: (value){})),
        const SizedBox(width: MOSizes.spaceBtwItems),
        Text.rich(
            TextSpan(
                children :[
                  TextSpan(text: ' ${MOTexts.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: '${MOTexts.privacyPolicy} ',
                       style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: MOColors.primary ,
                        decoration: TextDecoration.underline,
                        decorationColor: MOColors.white,
                      )),
                  TextSpan(text: '${MOTexts.and} ',style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: '${MOTexts.termsOfUse} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: MOColors.primary ,
                        decoration: TextDecoration.underline,
                        decorationColor:  MOColors.white ,
                      )),
                ]
            )
        )
      ],

    );
  }
}