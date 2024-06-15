import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/common/widgets/shimmer/shimmer.dart';
import 'package:orthotrade/features/orders/screens/customerorders/widgets/orders_list.dart';
import 'package:orthotrade/utils/constants/sizes.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';

import '../../controllers/orders/orders_controller.dart';


class CustomerOrdersScreen extends StatelessWidget {

  const CustomerOrdersScreen({super.key,
    this.showBackArrow=false,
  });

  final bool showBackArrow;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    controller.fetchOrdersList();
    final isdark= MOHelperFunctions.isDarkMode(context);
    return   Scaffold(
      /// App Bar
      appBar: MOAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall,),showBackArrow: showBackArrow,),
      /// Body
      body:  Obx(() {
        if (controller.isLoading.value) return const MOShimmer(width :10, height: 10);
        return
        Padding(
          padding: const EdgeInsets.all(MOSizes.defaultSpace * .8),
          child: MOOrdersListItems(ordersList: controller.ordersList),
        );
      }
      ),

    );
  }

}
