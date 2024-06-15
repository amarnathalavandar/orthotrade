import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

import '../../../controllers/home/home_controllers.dart';


class MOPromoSlider extends StatelessWidget {
  const MOPromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1.1,
              onPageChanged: (index,_)=>controller.updatePageIndicator(index)
          ),
          items: banners.map((url) =>  MORoundedImage(imageUrl: url)).toList() ,
        ),
        const SizedBox(height: MOSizes.spaceBtwItems,),
        Obx(
              ()=> Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i =0;i<banners.length;i++)
                MOCircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carousalCurrentIndex.value==i ? Colors.red :MOColors.grey
                ),
            ],
          ),
        )
      ],

    );
  }
}
