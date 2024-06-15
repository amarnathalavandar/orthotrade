import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/features/orders/controllers/orders/order_review_controller.dart';

import '../../../../../common/texts/product_text.dart';
import '../../../../../common/texts/product_title_text.dart';
import '../../../../../common/widgets/icons/mo_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/products_model.dart';


class MOProductLineItem extends StatelessWidget {
    MOProductLineItem({
    super.key,

     required this.line2,
      this.isDropDown=true,
     this.smallSize=true,
     this.selectedValue = '1',
      this.dropdownItems=const ['1','2','3'],
     this.add,
     this.remove,
      required this.quantity,
      required this.productsModel,
      this.line1='AMAR', this.updateQuantity,

  });

  final bool isDropDown;
  final String line1;
   final String line2;
  final bool smallSize;
  final String selectedValue;
  final List<String> dropdownItems;
   int quantity;
  final VoidCallback? add,remove,updateQuantity;
  final ProductsModel productsModel;



  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
final controller = OrderReviewController.instance;
final textController =TextEditingController(text:quantity.toString());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        /// Product Item Description with Product Desc2 and Product Ref
        Row(
          children: [
            Column(
              children: [
                SizedBox( width :140,child: MOProductNameText(name:productsModel.productDesc2,smallSize: smallSize,maxLine:2)),
                SizedBox( width :140,child: MOProductNameText(name:line2,maxLine:1,)),

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
                  onPressed: remove

                ),
               const SizedBox(width: 5.0,),

                Container(
                  alignment: Alignment.bottomRight,

                  width: 40,height: 30,
                  child:  TextField(
                    controller:textController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                     counterText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0), // Adjust height and width
                    ),
                    style:  TextStyle(fontSize: fontSize), // Adjust text size
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 5,
                    textAlign: TextAlign.center,
              /*onTap: () {
    // Clear the value if it's zero or less than zero
            if (quantity <= 0) {
            textController.clear();
         }
             },*/
                    onChanged: (value)
    {
    if(value.isNotEmpty) {
    //controller.Rxquantity.value=int.parse(value);
    }

    }
                  /*
                          //print('value---->$value');

                         //controller.quantity.value=int.parse(value);
                          //controller.updateQuantity(productsModel, int.parse(value));
                          print('AFTER IN PRODUCT LINE ITEM PAGE');
                        }
                    }*/

                  ),
                ),
          MOCircularIcon(
              icon: Iconsax.user,
              backgroundColor: MOColors.black,
              width: 30,
              height: 30,
              color: MOColors.white,
              onPressed:updateQuantity),        //  Text(quantity.toString(),style: Theme.of(context).textTheme.titleSmall,),
                 const SizedBox(width: 5.0,),
              /*  MOCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: MOColors.black,
                  width: 30,
                  height: 30,
                  color: MOColors.white,
                onPressed:add),*/
            ]
            )
      ],
    );
  }

}



