import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../features/orders/screens/forms/client_registration_form/client_registration_form.dart';
import '../../../features/orders/screens/forms/order_form/order_form_page.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

import '../../styles/shadow_style.dart';

import '../../texts/product_title_text.dart';
import '../containers/rounded_container.dart';

class MOFormCardVertical extends StatelessWidget {
  const MOFormCardVertical({super.key,
    this.backgroundColor=Colors.blue, required this.title, this.submitCount='0', this.wishlistColor, required this.iconShape});


  final Color backgroundColor;
  final String title;
  final String submitCount;
  final Color? wishlistColor;
  final IconData iconShape;

  @override
  Widget build(BuildContext context) {
  final isDark = MOHelperFunctions.isDarkMode(context);
  print('submitCount--->$submitCount');

   /// Container with side paddings, color, edges, radius and shadow

    return GestureDetector(
      onTap: () {
        print(title);
        if(title=="Client Registration Form") {
          Get.to(()=> ClientRegistrationForm(formTitle: title,));
        }
        if(title=="Products Order Form") {
          Get.to(()=> FormPage(formTitle: title,));
        }
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MOShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MOSizes.productImageRadius),
          color: isDark? MOColors.darkerGrey : MOColors.white,
        ),
        child: Column(
          children: [
            MORoundedContainer(
              height: 170,
              padding:const  EdgeInsets.all(MOSizes.sm),
              backgroundColor: backgroundColor,
              child: Stack(
                children: [
                  ///Order Count Tag
                 Positioned(

                   top: 12,
                   child:
                   submitCount!='0'?
                   MORoundedContainer(
                      radius: MOSizes.sm,
                      backgroundColor:MOColors.secondary.withOpacity(0.8),
                      padding:  const EdgeInsets.symmetric(horizontal: MOSizes.sm,vertical: MOSizes.xs),
                      child: Text(submitCount, style:  Theme.of(context).textTheme.labelLarge!.apply(color:MOColors.black),),

                    ): Text(''),
                 ),
                  /// Form Title
                  Positioned(
                      top:60,
                      right: 0,
                      left: 8,
                      child:MOProductTitleText(title:title,smallSize: false),
                  ),

                  /// Arrow Title
                  const Positioned(
                    top:130,
                    right: 2,
                    child:Icon(Iconsax.arrow_right_34),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MOSizes.spaceBtwItems/2,),

          ],
        ),
      ),
    );
  }
}



