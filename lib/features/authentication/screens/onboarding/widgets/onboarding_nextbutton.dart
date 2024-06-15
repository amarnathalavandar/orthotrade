import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MOHelperFunctions.isDarkMode(context);
    return Positioned(
      right: MOSizes.defaultSpace,
      bottom: MODeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
          onPressed: () {
            OnBoardingController.instance.nextPage();
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? MOColors.primary : MOColors.black),
          child: const Icon(
            Iconsax.arrow_right_3,
          )),

    );
  }
}
