import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class MOAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MOAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow=false,
    this.showLogo=true
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final bool isdark = MOHelperFunctions.isDarkMode(context);

   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MOSizes.md),
      child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(onPressed: ()=> Get.back(), icon:  Icon(Iconsax.arrow_left_2,
            color: isdark ? MOColors.white : MOColors.dark,),)
              : leadingIcon !=null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)):null,
          title:title,
          actions:showLogo
          ? [const Image(image: AssetImage(MOImages.darkAppLogo))] :null,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MODeviceUtils.getAppBarHeight());


}
