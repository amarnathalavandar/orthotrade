import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/orders/models/product_group_model.dart';

import '../../../../../common/texts/product_text.dart';
import '../../../../../common/widgets/icons/mo_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/orders/order_review_controller.dart';
import '../../../models/products_model.dart';

class MOProductItems extends StatelessWidget {
  const MOProductItems( {
    super.key,
    required this.mainProducts,
    required this.controller,

  });

  final ProductGroupModel mainProducts;
  final OrderReviewController controller;
   // Move outside build method

  @override
  Widget build(BuildContext context) {
    final orderedItems=controller.orderItems;
    final List<TextEditingController> textControllers = List.generate(mainProducts.productList.length, (index) => TextEditingController());

    return
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mainProducts.productList.length,
        itemBuilder: (context, subIndex) {
          ProductsModel product = mainProducts.productList[subIndex];
          return ListTile(
            subtitle:
            Obx(() {

              int newIndex=orderedItems.indexWhere((product1) => product1.productId == product.id);
              int quantity=newIndex >= 0 && newIndex < orderedItems.length
                  ? orderedItems[newIndex].quantity ?? 0
                  : 0;

              textControllers[subIndex].text = quantity.toString();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Product Item Description with Product Desc2 and Product Ref
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox( width :140,child: MOProductNameText(name:product.productDesc2,smallSize: false,maxLine:2)),
                          SizedBox( width :140,child: MOProductNameText(name:product.productRef,maxLine:1,)),
                        ],
                      )
                    ],
                  ),

                  Row(

                      children: [
                        MOCircularIcon(
                            icon: Iconsax.minus,
                            backgroundColor: MOColors.darkGrey,
                            width: 30,
                            height: 30,
                            color: MOColors.white,
                            onPressed: () =>controller.removeOneFromCart(product)

                        ),
                        const SizedBox(width: 5.0,),

                        Container(
                          alignment: Alignment.bottomRight,

                          width: 40,height: 30,
                          child:  TextField(
                              controller:textControllers[subIndex],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0), // Adjust height and width
                              ),
                              style:  const TextStyle(fontSize: 12.0), // Adjust text size
                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              maxLength: 5,
                              textAlign: TextAlign.center,
                              onTap: () {
                                if (textControllers[subIndex].text == '0') {
                                  textControllers[subIndex].clear();
                                }

                              },
                              onChanged: (value)
                              {
                                int enteredValue = int.parse(value);
                                print('enteredValue---$enteredValue');
                                if (enteredValue > 10000) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alert'),
                                        content: Text('Maximum order quantity cannot exceed 10000'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  controller.updateQuantity(product, enteredValue);
                                }
                              }
                          ),
                        ),
                        /*    MOCircularIcon(
                                            icon: Iconsax.user,
                                            backgroundColor: MOColors.black,
                                            width: 30,
                                            height: 30,
                                            color: MOColors.white,
                                            onPressed:updateQuantity)*/       //  Text(quantity.toString(),style: Theme.of(context).textTheme.titleSmall,),
                        const SizedBox(width: 5.0,),
                        MOCircularIcon(
                            icon: Iconsax.add,
                            backgroundColor: MOColors.black,
                            width: 30,
                            height: 30,
                            color: MOColors.white,
                            onPressed:() =>controller.addOneToCart(product)),
                      ]
                  )
                ],
              );
            }
            ),
          );
        },
      );


  }
}
