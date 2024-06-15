import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_images.dart';

class MOUserProfileTile extends StatelessWidget {
  MOUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final controller = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isNetworkImage = controller.user.value.profilePicture.isNotEmpty;
      final image = isNetworkImage ? controller.user.value.profilePicture : MOImages.user;
      return ListTile(
        leading: MOCircularImage(padding: 0, image: image, width: 50, height: 50, isNetworkImage: isNetworkImage),
        title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: MOColors.white)),
        subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: MOColors.white)),
        trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: MOColors.white)),
      );
    });
  }
}
