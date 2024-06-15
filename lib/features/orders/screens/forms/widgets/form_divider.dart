import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';



class MOFormDivider extends StatelessWidget {
  const MOFormDivider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark= MOHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark? MOColors.darkGrey : MOColors.grey ,thickness: 0.5,indent: 60,endIndent: 5)),
      ],
    );
  }
}