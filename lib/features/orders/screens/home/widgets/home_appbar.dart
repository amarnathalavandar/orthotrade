import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/utils/constants/sizes.dart';



import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';


class MOHomeAppBar extends StatelessWidget {
  const MOHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(UserController());
    return MOAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const SizedBox(height: MOSizes.spaceBtwItems),
           Text(MOTexts.homeAppbarTitle,style: Theme.of(context).textTheme.labelMedium!.apply(color:MOColors.grey),),
          const SizedBox(height: MOSizes.cardRadiusXs),
          Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineSmall!.apply(color:MOColors.white),)
          ]
),
              const Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    SizedBox(height: 8),
                    Image(
                    height: 50,
                    image: AssetImage(MOImages.darkAppLogo),
              ),
                  ],
                )
            ],

    )
        ],
      ),

     // actions: [SNCartCounterIcon(onPressed: () {  },iconColor: SNColors.primary,)],
showLogo: false,
    );
  }
}