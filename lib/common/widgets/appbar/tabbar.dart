import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';


class MOTabBar extends StatelessWidget{
  const MOTabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
     tabs: tabs,
     isScrollable: true,
     indicatorColor: MOColors.primary,
     labelColor:  MOHelperFunctions.isDarkMode(context)? MOColors.white:MOColors.primary,
     unselectedLabelColor: MOColors.grey,

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MODeviceUtils.getAppBarHeight());
}
