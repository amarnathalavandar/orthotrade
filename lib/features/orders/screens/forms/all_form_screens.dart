import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/forms/form_card_vertical.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/home/home_controllers.dart';



class FormScreens extends StatelessWidget {

  const FormScreens({super.key,
    this.showBackArrow=false});

final bool showBackArrow;
  static HomeController get instance => Get.find();

  @override
  Widget build(BuildContext context) {


    final controller = HomeController.instance;
    //controller.fetchFormDetails();
    return Scaffold(
        appBar: MOAppBar(showBackArrow: showBackArrow,
            title: Text('Forms' ,
              style: Theme.of(context).textTheme.headlineSmall,)),
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: MOSizes.spaceBtwSections),

                const MOSearchContainer(
                    text: 'Search Forms',
                    icon: Iconsax.search_normal),

                const SizedBox(height: MOSizes.spaceBtwSections),
                MOGridLayout(
                    itemCount: controller.formsList.length,
                    itemBuilder: (_, index) => MOFormCardVertical(
                      iconShape: Iconsax.heart,
                      backgroundColor: Colors.white,
                      title: controller.formsList[index].formName,
                      submitCount: controller.formsList[index].count
                    )),
              ],

            ),
          ),
        ));
  }
}
