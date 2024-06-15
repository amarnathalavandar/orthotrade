import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../features/orders/screens/search/search.dart';
import '../../../utils/device/device_utility.dart';

class MOSearchContainer extends StatelessWidget {
  const MOSearchContainer({
    super.key,
    required this.text,
    this.icon =Iconsax.search_normal,
    this.showBackground =true,
    this.showBorder = true, this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: MOSizes.defaultSpace),
  });


  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = MOHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => SearchScreen()),
      child: Padding(
        padding:  padding,
        child: Container(
          width: MODeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(MOSizes.md),
          decoration: BoxDecoration(
              color: showBackground?
              isDark?
              MOColors.dark :
              MOColors.light:
              Colors.transparent,

              borderRadius: BorderRadius.circular(MOSizes.cardRadiusLg),

              border: showBorder? Border.all(color: MOColors.grey) : null
          ),
          child:  Row(
              children: [

                Icon(icon,color: MOColors.darkerGrey,),
                const SizedBox(width: MOSizes.spaceBtwItems,),
                Text(text,style: Theme.of(context).textTheme.bodySmall,)

              ]
          ),

        ),
      ),
    );
  }
}
