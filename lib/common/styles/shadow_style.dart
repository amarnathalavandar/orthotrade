import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class MOShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MOColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 3,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: MOColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalOrderShadow =BoxShadow(
      color: MOColors.darkGrey.withOpacity(0.1),
      blurRadius: 1,
      spreadRadius: 1.5,
      offset: const Offset(0, 1));
}
