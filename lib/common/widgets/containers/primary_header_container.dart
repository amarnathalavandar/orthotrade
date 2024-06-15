import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

import 'circular_container.dart';
import 'curved_edges_widget.dart';

class MOPrimaryHeaderContainer extends StatelessWidget {
  const MOPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MOCurvedEdgeWidget(
      child: Container(
        color: const Color.fromRGBO(6, 13, 50,1),
        padding: const EdgeInsets.only(bottom:0),
        child: Stack(
          children: [
            Positioned(top: -150,right: -250,child: MOCircularContainer(backgroundColor: MOColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100,right: -300,child: MOCircularContainer(backgroundColor: MOColors.textWhite.withOpacity(0.1))),
            child
          ],
        ),
      ),
    );
  }
}
