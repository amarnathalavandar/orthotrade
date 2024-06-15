import 'package:flutter/material.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/utils/constants/sizes.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});


final String orderId;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: MOAppBar(title: Text('Order Details',style: Theme.of(context).textTheme.headlineSmall,),
      showBackArrow: true,),

      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(MOSizes.defaultSpace),
        child: Column(
          children: [

            Text('$orderId Order Details Coming Soon....!!!', style: Theme.of(context).textTheme.labelLarge,)

          ],
        ),
      ),
    );
  }
}
