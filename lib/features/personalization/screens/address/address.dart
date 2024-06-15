import 'package:flutter/material.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/features/personalization/screens/address/widgets/single_address.dart';
import 'package:orthotrade/utils/constants/sizes.dart';


class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MOAppBar(
        showBackArrow: true,
        title: Text('Address',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MOSizes.defaultSpace),
          child: Column(
            children: [

              MOSingleAddress(),



            ],
          ),
        )
      ),



      
    );
  }
}
