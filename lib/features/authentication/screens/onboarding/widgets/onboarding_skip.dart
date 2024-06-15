import 'package:flutter/material.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
        top: MODeviceUtils.getAppBarHeight(),
        right: MOSizes.defaultSpace,
        child: TextButton(
          onPressed:controller.skipPage,

          child: const Text('Skip'),
        ));
  }
}
