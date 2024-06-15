import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MOCircularIcon extends StatelessWidget {
  const MOCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size=MOSizes.md,
    required this.icon,
    this.backgroundColor,
    this.onPressed, this.color,
  });

  final double? width,height,size;
  final IconData icon;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bool isDark = MOHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor!=null ?
          backgroundColor!
          : isDark ?
          MOColors.black.withOpacity(0.9) : MOColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
        ),

        child: IconButton(onPressed: onPressed,icon:Icon(icon),color:color,iconSize:size),
    );
  }
}
