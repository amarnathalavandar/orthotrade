import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/utils/constants/sizes.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

import '../../../../../common/styles/shadow_style.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../models/orders_list_model.dart';
import '../../orderdetails/order_details.dart';

class MOOrdersListItems extends StatelessWidget {

  const MOOrdersListItems(
      {super.key,
        required this.ordersList});


  final  RxList<OrdersListModel> ordersList;

  @override
  Widget build(BuildContext context) {
    final isDark =MOHelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      separatorBuilder: (_, __) => const SizedBox(
        height: MOSizes.spaceBtwItems,
        ),
      itemCount: ordersList.value.length,
      itemBuilder: (_, index) =>
          Container(
            decoration: BoxDecoration(
              boxShadow: [MOShadowStyle.horizontalOrderShadow],
              borderRadius: BorderRadius.circular(MOSizes.productImageRadius),
              color: isDark? MOColors.darkerGrey : MOColors.white,
            ),
            child: MORoundedContainer(
              showBorder: false,
              padding: const EdgeInsets.all(MOSizes.md),
              backgroundColor: MOHelperFunctions.isDarkMode(context)
                  ? MOColors.dark
                  : MOColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Row -1
                  Row(
                    children: [
                      /// 1 - Ship Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(
                        width: MOSizes.spaceBtwItems / 2,
                      ),

                      /// 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Completed',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: MOColors.primary, fontWeightDelta: 1),
                            ),
                            Text(
                                ordersList[index].orderDate.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      /// 3 - Icon
                      IconButton(
                          onPressed: () =>Get.to(()=> OrderDetailsScreen(orderId: ordersList[index].orderId,)),
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: MOSizes.iconSm,
                          ))
                    ],
                  ),
                  const SizedBox(height: MOSizes.spaceBtwItems),

                  ///Row -2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 - Tag Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(
                              width: MOSizes.spaceBtwItems / 2,
                            ),

                            /// 2 - Order Number
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    ordersList[index].orderId,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: MOSizes.spaceBtwSections * .9,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 - Dollar Icon
                            const Icon(Iconsax.dollar_square),
                            const SizedBox(
                              width: MOSizes.spaceBtwItems / 2,
                            ),

                            /// 2 - Invoice value
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Invoice Value',
                                      style: Theme.of(context).textTheme.labelMedium),
                                  Text(
                                    ordersList[index].invoiceValue.toString(),
                                    style: Theme.of(context).textTheme.titleMedium,
                                    softWrap: true,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
