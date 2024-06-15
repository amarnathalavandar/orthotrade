import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/orders/controllers/orders/order_review_controller.dart';
import 'package:orthotrade/features/orders/screens/customerorders/order_review.dart';
import 'package:orthotrade/utils/constants/colors.dart';
import 'package:orthotrade/utils/constants/image_strings.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

import '../../../../../common/widgets/dialog/dialog.dart';
import '../../../../../common/widgets/shimmer/stepper_shimmer.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../pdf/invoice_pdf_generator.dart';
import '../../../../pdf/order_form.dart';
import '../../../../pdf/invoice_preview.dart';
import '../../../controllers/products/products_controller.dart';
import '../../customerorders/widgets/product_items.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.formTitle});

  final String formTitle;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.put(OrderReviewController());
    final productController = Get.put(ProductsController());
    final TextEditingController textEditingController = TextEditingController();
    bool lastField = false;
    return Scaffold(
        appBar: MOAppBar(
            showBackArrow: true,
            title: Text(widget.formTitle),
            actions: [Image(image: AssetImage(MOImages.darkAppLogo))]),
        body: Scrollbar(
          thickness:8,
          thumbVisibility: true,
          interactive: true,
          radius: const Radius.circular(10),
          scrollbarOrientation: ScrollbarOrientation.right,
          child: Obx(() {
            if (!productController.isLoading.value) return const StepperShimmer();
            return Padding(
                padding: const EdgeInsets.all(0),
                child: Stepper(
                  currentStep: _currentStep,
                  onStepTapped: (int newIndex) {
                    setState(() {
                      _currentStep = newIndex;
                    });
                  },
                  onStepContinue: () {
                    setState(() {
                      _currentStep < productController.allproductgroups.length - 1
                          ? _currentStep += 1
                          : _currentStep = 0;
                    });
                  },
                  onStepCancel: () {
                    if (_currentStep != 0) {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }
                  },
                  type: StepperType.vertical,
                  steps: productController.allproductgroups.map((products) {
                    int index =
                        productController.allproductgroups.indexOf(products);

                    /// BRACKETS 1
                    return Step(
                      title: Text(products.productGroupDesc,
                          style: Theme.of(context).textTheme.titleMedium),
                      content: Align(
                        alignment: Alignment.centerLeft,
                        child:
                            MOProductItems(
                                mainProducts: products,
                                controller: reviewController,
                            ),
                      ),

                      isActive:
                          _currentStep == index, // Highlight the selected step
                    );
                  }).toList(),
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    if (lastField == true) {
                      return Container();
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentStep != 0 && _currentStep!= 9) // skip on last step
                          OutlinedButton(
                            onPressed: controls.onStepCancel,
                            child: const Text('Previous',
                                style: TextStyle(fontSize: 12)),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (_currentStep!= 9)

                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red.shade900),
                            onPressed: controls.onStepContinue,
                            child: const Text('Next',
                                style: TextStyle(fontSize: 12)),
                          ),
                      ],
                    );
                  },
                ));
          }),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0, // Remove shadow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.close_square),
                          SizedBox(width: 8.0),
                          Text('Cancel'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => reviewController.validateOrder()
                            //? Get.to(() =>  OrderReviewScreen())
                        ? Get.to(() =>  PdfPreviewPage())
                          : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MODialog(
                            title: 'Check your Order!!',
                            message:
                            'Your order needs quantity for at least one item!',
                          );
                        },
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.arrow_right),
                          SizedBox(width: 8.0),
                          Text('Review'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

    );
  }
}
