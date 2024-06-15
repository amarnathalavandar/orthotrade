import 'package:flutter/material.dart';
import 'package:orthotrade/features/personalization/controllers/user_controller.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/constants/sizes.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';

class MOSingleAddress extends StatelessWidget {
  const MOSingleAddress({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final isdark = MOHelperFunctions.isDarkMode(context);
    return MORoundedContainer(
      padding: const EdgeInsets.all(MOSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: isdark ? MOColors.primary : Colors.transparent,
      borderColor: isdark ? MOColors.darkGrey : Colors.grey,
      margin: const EdgeInsets.only(bottom: MOSizes.spaceBtwItems),
      child: Stack(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.user.value.fullName,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: MOSizes.sm / 2,
              ),
               Text(
               controller.user.value.phoneNumber,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

              ),
              const SizedBox(
                height: MOSizes.sm / 2,
              ),
              Text( controller.user.value.fullAddress,
                  style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
            ],
          )
        ],
      ),
    );
  }
}
