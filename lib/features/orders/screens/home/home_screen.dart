import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/orders/controllers/home/home_controllers.dart';
import 'package:orthotrade/features/orders/screens/forms/all_form_screens.dart';

import 'package:orthotrade/features/orders/screens/home/widgets/home_appbar.dart';
import 'package:orthotrade/features/orders/screens/home/widgets/home_slider.dart';

import '../../../../common/texts/section_heading.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/forms/form_card_vertical.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomeController());
    controller.fetchFormDetails();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [

              /// Header -App Bar + Search Bar + Categories
              const MOPrimaryHeaderContainer(
                child: Column(
                  children: [

                    /// -- App Bar
                    MOHomeAppBar(),
                    SizedBox(height: MOSizes.spaceBtwSections),

                    /// -- Search Bar
                    MOSearchContainer(
                        text: 'Search Forms', icon: Iconsax.search_normal),
                    SizedBox(height: MOSizes.spaceBtwSections),

                    ///  -- Categories & Heading
                    /*Padding(
                      padding: EdgeInsets.only(left: MOSizes.defaultSpace),
                      child: Column(
                        children: [
                          /// Heading
                          MOSectionHeading(
                            title: 'Popular Categories',
                            showActionButton: false,
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: MOSizes.spaceBtwItems,
                          ),

                          ///Categories
                         // THomeCategory(),
                        ],
                      ),
                    ),*/
                    SizedBox(height: MOSizes.spaceBtwSections,)
                  ],
                ),
              ),

              /// Body
              Padding(
                padding: const EdgeInsets.all(MOSizes.defaultSpace),
                child:
                Column(
                  children: [

                    /// Slider
                    const MOPromoSlider(banners: [
                      MOImages.banner5,
                      MOImages.banner6,
                      MOImages.banner7,
                      MOImages.banner8
                    ],),
                    const SizedBox(height: MOSizes.spaceBtwItems),

                    /// Heading
                     MOSectionHeading(title: 'Forms',onPressed :()=>Get.to(()=> const FormScreens(showBackArrow: true,))),
                    const SizedBox(height: MOSizes.spaceBtwItems),

                    /// Popular Products - Grid Layout with products as Custom Containers
                        MOGridLayout(
                            itemCount: controller.formsList.length,
                            itemBuilder: (_, index) =>
                            MOFormCardVertical(
                              iconShape: Iconsax.heart,
                              backgroundColor: Colors.white,
                              title: controller.formsList[index].formName,
                              submitCount:controller.formsList[index].count
                              )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
