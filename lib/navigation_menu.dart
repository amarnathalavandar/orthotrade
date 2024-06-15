import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

import 'features/orders/controllers/products/products_controller.dart';
import 'features/orders/screens/customerorders/customer_orders.dart';
import 'features/orders/screens/forms/all_form_screens.dart';
import 'features/orders/screens/home/home_screen.dart';
import 'features/personalization/screens/settings/settings_screen.dart';



class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NavigationController());
    final dark = MOHelperFunctions.isDarkMode(context);

    return Scaffold(

        bottomNavigationBar: Obx(
        ()=> NavigationBar(
          elevation: 0,
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value=index,
          backgroundColor: dark? MOColors.black : MOColors.white,
          indicatorColor: dark? MOColors.white.withOpacity(0.1): MOColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.document_text), label: 'Forms'),
            NavigationDestination(icon: Icon(Iconsax.bag_tick), label: 'My Orders'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
    body:Obx(()=>controller.screens[controller.selectedIndex.value])
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens=[
    const HomeScreen(),
    const FormScreens(),
    const CustomerOrdersScreen(),
    const SettingsScreen(),
  ];

}


