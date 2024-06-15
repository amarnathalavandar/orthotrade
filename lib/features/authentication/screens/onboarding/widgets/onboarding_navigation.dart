import 'package:flutter/material.dart';
import 'package:orthotrade/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    final dark = MOHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: MODeviceUtils.getBottomNavigationBarHeight() + 25,
      left: MOSizes.defaultSpace,


      child: SmoothPageIndicator(

          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          effect:  ExpandingDotsEffect(activeDotColor: dark? MOColors.light :MOColors.dark,dotHeight: 6),
          count: 3),
    );
  }
}