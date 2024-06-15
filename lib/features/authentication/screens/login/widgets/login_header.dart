import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class MOLoginHeader extends StatelessWidget {
  const MOLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          height: 180,
          image: AssetImage(MOImages.darkAppLogo),
        ),

        Text(MOTexts.loginTitle ,style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: MOSizes.sm,),

        Text(MOTexts.loginSubTitle,style: Theme.of(context).textTheme.titleSmall,)

      ],
    );
  }
}