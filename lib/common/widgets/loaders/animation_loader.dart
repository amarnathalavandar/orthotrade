import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/constants/sizes.dart';


class MOAnimationLoaderWidget extends StatelessWidget {
  const MOAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
       this.showAction =false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Lottie.asset(
             animation,width: MediaQuery.of(context).size.width * 0.8 ),
          const SizedBox(height: MOSizes.defaultSpace,),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MOSizes.defaultSpace,),
          showAction
          ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: MOColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: MOColors.light),
                ),
            ),
          )
          : const SizedBox(),
        ],
      ),
    );
  }
}
