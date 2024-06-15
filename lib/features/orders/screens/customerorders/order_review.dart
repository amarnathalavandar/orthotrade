import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/features/orders/controllers/orders/order_review_controller.dart';
import 'package:orthotrade/features/personalization/controllers/user_controller.dart';
import 'package:orthotrade/utils/constants/sizes.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/image_strings.dart';

class OrderReviewScreen extends StatelessWidget {
  OrderReviewScreen({super.key});

  final controller = OrderReviewController.instance;
  final userController = UserController.instance;
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final orderedItems = controller.orderItems;
    controller.updateInvoiceTotal();


    final int discountPercent = localStorage.read('DISCOUNTED PERCENT');
    int index = controller.orderItems.length;
    return Scaffold(
        appBar: const MOAppBar(
            title: Text('Order Review'), showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MOSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                /// COMPANY LOGO AND ITS ADDRESS and INVOICE HEADING
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),

                  },
                  children: [
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.only(right:100),
                            child:Image(image: AssetImage(MOImages.darkAppLogo),width: 100,height: 100,),

                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userController.user.value.shippingAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// BILLING AND SHIPPING ADDRESS
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'BILLING ADDRESS',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SHIPPING ADDRESS',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userController.user.value.billingAddress,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userController.user.value.shippingAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //// PRODUCT DETAILS PRICE
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Item Description',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Qty',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Price',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Discount',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Amount',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...orderedItems.map((product) {
                      return TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.productDesc),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.quantity.toString()),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.rate.toString()),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.discountedPrice.toString()),
                      ),
                            ),

                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(MOHelperFunctions.getDiscountedAmount(product.rate,product.discountedPrice, product.quantity).toString()),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Quantity :',
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                    ),
                    const SizedBox(width: MOSizes.sm),
                    Text(
                      controller.totalNoOfItems.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                    ),
                    const SizedBox(width: MOSizes.sm),
                    Text(
                      'Total Invoice value :',
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                    ),
                    const SizedBox(width: MOSizes.sm),
                    Text(
                      controller.postDiscountInvoiceValue.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: MOSizes.spaceBtwSections),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Congratulations! \nYou have saved ',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                        children: <TextSpan>[
                          const TextSpan(
                            text: '\$',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                          TextSpan(
                            text: MOHelperFunctions.getTotalDiscountedAmount(
                                controller.preDiscountInvoiceValue,
                                discountPercent),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                          TextSpan(
                            text: ' on this wholesale order!',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: MOSizes.defaultSpace,
              vertical: MOSizes.defaultSpace / 2),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (() => controller.uploadOrderItems()),
              child: const Text('Submit Order'),
            ),
          ),
        )
    );
  }
}