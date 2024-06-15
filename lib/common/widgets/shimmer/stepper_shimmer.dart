import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StepperShimmer extends StatelessWidget {
  const StepperShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(

      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Stepper(
        currentStep: 0,
        onStepContinue: () {},
        onStepCancel: () {},
        onStepTapped: (step) {},
        steps: List.generate(9, (index) {
          return const Step(
            title: Text(''),
            content: SizedBox(
              height: 3,

            ),
          );
        }),
      ),
    );
  }
}
