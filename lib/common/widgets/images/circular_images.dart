import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MOCircularImage extends StatelessWidget {
  const MOCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage =false,
    this.overlayColor,
    this.backgroundColor,
     this.width ,
     this.height,
     this.padding = MOSizes.sm
  });


  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double? width,height,padding;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(

        /// If image background is null, then switch it to light AND dark mode color design.

        color: backgroundColor ?? (MOHelperFunctions.isDarkMode(context)
            ? MOColors.black
            : MOColors.white),
        borderRadius: BorderRadius.circular(100)
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: Image(
            fit:fit,
            image: isNetworkImage? NetworkImage(image): AssetImage(image) as ImageProvider,
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
