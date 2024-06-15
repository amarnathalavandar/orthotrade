import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:orthotrade/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../common/texts/section_heading.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/circular_images.dart';
import '../../../../common/widgets/shimmer/shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: MOAppBar(
        showBackArrow: true,
        title: Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all((MOSizes.defaultSpace)),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : MOImages.user;
                      return controller.imageUploading.value
                          ? const MOShimmer(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : MOCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              /// Profile Information
              const SizedBox(
                height: MOSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: MOSizes.spaceBtwItems,
              ),
              const MOSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: MOSizes.spaceBtwItems,
              ),

              MOProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () {},
              ),
              MOProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              MOProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              const Divider(),




            ],
          ),
        ),
      ),
    );
  }
}
