import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:orthotrade/utils/constants/image_strings.dart';
import 'package:orthotrade/utils/constants/text_strings.dart';

import 'widgets/onboarding_navigation.dart';
import 'widgets/onboarding_nextbutton.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [

          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
             OnBoardingPage(
               image:MOImages.onBoardingImage1,
               title: MOTexts.onBoardingTitle1,
               subTitle: MOTexts.onBoardingSubTitle1,

             ),
              OnBoardingPage(
                image:MOImages.onBoardingImage2,
                title: MOTexts.onBoardingTitle2,
                subTitle: MOTexts.onBoardingSubTitle2,

              ),
              OnBoardingPage(
                image:MOImages.onBoardingImage3,
                title: MOTexts.onBoardingTitle3,
                subTitle: MOTexts.onBoardingSubTitle3,

              ),
            ],
          ),

          // Skip Button
          const onBoardingSkip(),
          // Dot Navigation SmoothPageIndicator
          const onBoardingDotNavigation(),
          // Circular Button
          const onBoardingNextButton()
        ],
      ),

    );
  }
}





