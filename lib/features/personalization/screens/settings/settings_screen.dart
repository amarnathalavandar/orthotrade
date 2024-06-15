import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/texts/section_heading.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../orders/screens/customerorders/customer_orders.dart';
import '../../controllers/user_controller.dart';
import '../address/address.dart';
import '../profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ///  Header
            MOPrimaryHeaderContainer(
                child: Column(children: [
                  MOAppBar(
                      title: Text('Account',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: MOColors.white))),

                  /// User Profile Card
                  MOUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: MOSizes.spaceBtwSections),


                ])),

            /// Body
            Padding(
                padding: const EdgeInsets.all(MOSizes.defaultSpace),
                child: Column(
                    children: [
                    const MOSectionHeading(title: 'Account Settings',
                    showActionButton: false),
                const SizedBox(height: MOSizes.spaceBtwItems),

                MOSettingsMenuTitle(icon: Iconsax.safe_home,
                  title: 'My Address',
                  subTitle: 'Set shopping delivery address',
                  onTap: () => Get.to(() => const UserAddressScreen()),),

                MOSettingsMenuTitle(icon: Iconsax.bag_tick,
                  title: 'My Orders',
                  subTitle: 'In-progress and Completed Orders',
                  onTap: () => Get.to(() => const CustomerOrdersScreen(
                    showBackArrow: true,)),
                ),

                /// App Settings
                const SizedBox(height: MOSizes.spaceBtwSections,),
                /*const MOSectionHeading(
                  title: 'App Settings', showActionButton: false,),
                const SizedBox(height: MOSizes.spaceBtwItems,),
                 const MOSettingsMenuTitle( icon:Iconsax.document_upload,title:'Load Data',subTitle:'Upload Data to your cloud Firebase'),
                MOSettingsMenuTitle( icon:Iconsax.location,title:'Load Data',subTitle:'Set recommendation based on location',trailing: Switch(activeTrackColor: Colors.red.shade400,value: true, onChanged: (value) {})),*/

            /// Logout Button
            const SizedBox(height: MOSizes.spaceBtwSections,),
            /*SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () =>
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const orderedItemDetailsg(
                          nextScreen: 'loginscreen',
                          title: 'Logout',
                          message: 'Do you want to Log out?',
                          buttonText: 'Yes',
                        );
                      },
                    )
                  }, child: const Text('Logout')),
            ),*/
                      SizedBox(
                          width: double.infinity, child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout'))),
            const SizedBox(height: MOSizes.spaceBtwSections * 2.5,)


          ],
        ),

      )
      ],
    ),)
    ,
    );
  }
}
